import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitch_rss_feed/controller/observer/reset_provider.dart';
import 'package:twitch_rss_feed/home_page.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        ResetProviderState(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitch RSS Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Twitch RSS Feed'),
    );
  }
}
