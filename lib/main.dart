import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'states/_states.dart';
import 'ui/_ui.dart';
import 'ui_kit/_ui_kit.dart';

void main() {
  final store = Store<StickerState>(
    stickerReducer,
    initialState: StickerState.initial(),
  );
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.store});

  final Store<StickerState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<StickerState>(
      store: store,
      child: StoreConnector<StickerState, bool>(
        distinct: true,
        converter: (store) => store.state.light,
        builder: (context, light) {
          return MaterialApp(
            title: 'Sunny Stickers',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: light ? ThemeMode.light : ThemeMode.dark,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
