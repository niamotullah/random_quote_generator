import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quote_generator/quote_generator.dart';

Future<void> main() async {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => QuoteGenerator(),
    ),
  );
}
