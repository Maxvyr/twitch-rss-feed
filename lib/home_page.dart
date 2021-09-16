import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twitch_rss_feed/controller/util/navigation.dart';
import 'package:twitch_rss_feed/models/twitch_vod.dart';
import 'package:twitch_rss_feed/views/show_vod.dart';
import 'package:webfeed/webfeed.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _textEditingController;

  // TODO reformat code
  Future<List<TwitchVOD>> callRSSFeed() async {
    List<TwitchVOD> list = [];
    final res = await http
        .get(Uri.parse("https://twitchrss.appspot.com/vod/greyfoxxtv"));
    debugPrint(res.statusCode.toString());
    if (res.statusCode == 200) {
      final mapRes = RssFeed.parse(res.body);
      debugPrint(mapRes.title);
      debugPrint("${mapRes.items!.length}");
      final items = mapRes.items!;
      for (var item in items) {
        final twitchVOD = TwitchVOD.fromRSS(item);
        list.add(twitchVOD);
        debugPrint(twitchVOD.title);
      }
      debugPrint("${list.length}");
    } else {
      debugPrint(res.statusCode.toString());
    }

    return list;
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              //TODO recover field in text and add then in link get
              controller: _textEditingController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          callRSSFeed().then(
            (list) => Utils.goToNextPage(
              context,
              ShowVod(
                list: list,
              ),
            ),
          );
        },
        tooltip: "Rechercher",
        label:  Row(
          children: const [
            Text("Rechercher"),
            Icon(Icons.search),
          ],
        ),
      ),
    );
  }
}
