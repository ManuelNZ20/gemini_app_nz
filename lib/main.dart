import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'config/config.dart';

Future<void> main() async {
  AppTheme.setSystemUIOverlayStyle(isDarkMode: true);
  runApp(ProviderScope(child: const GeminiApp()));
}
