import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetProviderState extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    debugPrint("""
    didUpdateProvider
      "provider": "${provider.name ?? provider.runtimeType}",
  "preivousValue": "$previousValue",
  "newValue": "$newValue",
  "providerContainer": "${container.depth}",
    """);
  }
}
