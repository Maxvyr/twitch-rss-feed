import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitch_rss_feed/models/twitch_vod.dart';
import 'package:twitch_rss_feed/repository/netword_request.dart';

final listVODProvider =
    FutureProvider.family<List<TwitchVOD>, String>((ref, streamer) async {
  return callRSSFeed(streamer);
});
