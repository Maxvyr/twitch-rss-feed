import 'package:webfeed/webfeed.dart';

class TwitchVOD {
  late String title;
  late String img;
  late String link;
  late DateTime date;

  TwitchVOD.fromRSS(RssItem rss) {
    title = rss.title??  "No Title";
    // TODO filtre des for recover link img
    img = rss.description ?? "No Desc";
    link = rss.link ?? "No Link";
    date = rss.pubDate ?? DateTime.now();
  }
}
