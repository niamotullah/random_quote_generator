import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quote_generator/quote_generator.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !((kIsWeb && kReleaseMode) && Platform.isAndroid),
      builder: (context) => QuoteGenerator(),
    ),
  );
}
