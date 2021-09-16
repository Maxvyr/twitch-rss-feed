import 'package:flutter/material.dart';
import 'package:twitch_rss_feed/models/twitch_vod.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowVod extends StatefulWidget {
  late final List<TwitchVOD> list;
  ShowVod({Key? key, required this.list}) : super(key: key);

  @override
  _ShowVodState createState() => _ShowVodState();
}

class _ShowVodState extends State<ShowVod> {
  void _launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw "Could not open this $url";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: widget.list.length,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          itemBuilder: (context, i) {
            final twitchVod = widget.list[i];
            debugPrint("here => ${twitchVod.title}");
            return Container(
                child: Column(
              children: [
                Text(twitchVod.title),
                Text(twitchVod.link),
                Text(twitchVod.date.toString()),
                ElevatedButton(
                  onPressed: () {
                    _launchUrl(twitchVod.link);
                  },
                  child: const Text("Voir le live"),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
