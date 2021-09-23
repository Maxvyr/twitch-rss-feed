import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:twitch_rss_feed/models/twitch_vod.dart';
import 'package:webfeed/webfeed.dart';

Future<List<TwitchVOD>> callRSSFeed(String streamer) async {
  List<TwitchVOD> list = [];
  final res =
      await http.get(Uri.parse("https://twitchrss.appspot.com/vod/$streamer"));
  debugPrint(res.statusCode.toString());
  if (res.statusCode == 200) {
    final mapRes = RssFeed.parse(res.body);
    final items = mapRes.items!;
    for (var item in items) {
      final twitchVOD = TwitchVOD.fromRSS(item);
      list.add(twitchVOD);
    }
  } else {
    debugPrint(res.statusCode.toString());
  }

  return list;
}
