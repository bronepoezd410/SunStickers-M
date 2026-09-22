import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'states/_states.dart';
import 'ui/_ui.dart';
import 'ui_kit/_ui_kit.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StickerProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StickerProvider>(
      builder: (context, provider, _) {
        return MaterialApp(
          title: 'Sunny Stickers',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: provider.light ? ThemeMode.light : ThemeMode.dark,
          home: const HomeScreen(),
        );
      },
    );
  }
}
