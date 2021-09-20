import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:twitch_rss_feed/controller/util/navigation.dart';
import 'package:twitch_rss_feed/models/twitch_vod.dart';
import 'package:twitch_rss_feed/views/show_vod.dart';
import 'package:webfeed/webfeed.dart';

final streamerNameisOkProvider = StateProvider<bool>((ref) => false);
final textisEmptyProvider = StateProvider<bool>((ref) => false);

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final TextEditingController _textEditingController = TextEditingController();

  // TODO reformat code
  Future<List<TwitchVOD>> callRSSFeed(String streamer) async {
    List<TwitchVOD> list = [];
    final res = await http
        .get(Uri.parse("https://twitchrss.appspot.com/vod/$streamer"));
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
  Widget build(BuildContext context, WidgetRef ref) {
    final streamerNotExistProvider = ref.watch(streamerNameisOkProvider);
    var streamerNameIsOk = streamerNotExistProvider.state;
    final textFieldProvider = ref.watch(textisEmptyProvider);
    var textFieldIsEmpty = textFieldProvider.state;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: "Streamer name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              streamerNameIsOk
                  ? const Text("Ce streamer n'existe pas")
                  : const SizedBox(),
              textFieldIsEmpty
                  ? const Text("Tu n'as pas rentrer de nom de streamer")
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_textEditingController.text.isEmpty) {
            ref.read(textisEmptyProvider).state =
                !ref.read(textisEmptyProvider).state;
          } else {
            searchVOD(context, ref);
          }
        },
        tooltip: "Rechercher",
        label: Row(
          children: const [
            Text("Rechercher"),
            Icon(Icons.search),
          ],
        ),
      ),
    );
  }

  void searchVOD(BuildContext context, WidgetRef ref) {
    callRSSFeed(_textEditingController.text).then((list) {
      if (list.isEmpty) {
        ref.read(streamerNameisOkProvider).state =
            !ref.read(streamerNameisOkProvider).state;
      } else {
        Utils.goToNextPage(
          context,
          ShowVod(
            list: list,
          ),
        );
      }
    });
  }
}
