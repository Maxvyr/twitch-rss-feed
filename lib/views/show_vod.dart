import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitch_rss_feed/state/state_manager.dart';
import 'package:twitch_rss_feed/views/tile_vod.dart';

class ShowVod extends ConsumerWidget {
  final String streamerName;
  const ShowVod({required this.streamerName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listVod = ref.watch(listVODProvider(streamerName));

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
              return TileVOD(vod: vod);
            },
          );
        },
      ),
    );
  }
}
