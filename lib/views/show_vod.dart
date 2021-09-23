import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitch_rss_feed/state/state_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowVod extends ConsumerWidget {
  final String streamerName;
  const ShowVod({required this.streamerName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listVod = ref.watch(listVODProvider(streamerName));

    void _launchUrl(String url) async {
      await canLaunch(url)
          ? await launch(url)
          : throw "Could not open this $url";
    }

    return Scaffold(
      body: listVod.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => Center(
          child: Text("ERROR => $err"),
        ),
        data: (list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              final vod = list[i];

              return SizedBox(
                  child: Column(
                children: [
                  Text(vod.title),
                  Text(vod.link),
                  Text(vod.date.toString()),
                  ElevatedButton(
                    onPressed: () {
                      _launchUrl(vod.link);
                    },
                    child: const Text("Voir le live"),
                  ),
                ],
              ));
            },
          );
        },
      ),
    );
  }
}
