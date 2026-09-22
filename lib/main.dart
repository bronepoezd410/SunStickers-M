import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states/_states.dart';
import 'ui/_ui.dart';
import 'ui_kit/_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StickerCubit(),
      child: BlocBuilder<StickerCubit, StickerState>(
        buildWhen: (previous, current) => previous.light != current.light,
        builder: (context, state) {
          return MaterialApp(
            title: 'Sunny Stickers',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.light ? ThemeMode.light : ThemeMode.dark,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
