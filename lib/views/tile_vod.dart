import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:twitch_rss_feed/models/twitch_vod.dart';
import 'package:url_launcher/url_launcher.dart';

class TileVOD extends StatelessWidget {
  final TwitchVOD vod;
  const TileVOD({required this.vod, Key? key}) : super(key: key);

  void _launchUrl(String url) async {
    await canLaunch(url) ? await launch(url) : throw "Could not open this $url";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            35.0,
          ),
          color: Colors.blueGrey,
          boxShadow: const [
            BoxShadow(
              color: Color(0xff555555),
              offset: Offset(-3.6, -3.6),
              blurRadius: 38,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                vod.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              DateFormat("dd-MM-yyyy").format(vod.date),
              style: const TextStyle(
                fontSize: 8.0,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 200.0,
              child: Center(
                child: Html(data: vod.img),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _launchUrl(vod.link);
              },
              child: const Text("Voir le live"),
            ),
          ],
        ),
      ),
    );
  }
}
