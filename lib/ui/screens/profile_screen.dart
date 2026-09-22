import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/_states.dart';
import '../../ui_kit/_ui_kit.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final light = ref.watch(stickerProvider.select((s) => s.light));

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(AppAsset.profileImage, width: 300),
          ),
          Text(
            "Hello Sunny!",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: Text(
              light ? 'Light theme' : 'Dark theme',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            value: light,
            onChanged: (_) => ref.read(stickerProvider.notifier).toggleTheme(),
          ),
        ],
      ),
    );
  }
}
