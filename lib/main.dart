import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'states/_states.dart';
import 'ui/_ui.dart';
import 'ui_kit/_ui_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Provider(
      create: (_) => StickerStore(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final store = context.read<StickerStore>();
        return MaterialApp(
          title: 'Sunny Stickers',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: store.light.value ? ThemeMode.light : ThemeMode.dark,
          home: const HomeScreen(),
        );
      },
    );
  }
}
