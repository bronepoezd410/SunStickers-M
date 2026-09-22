import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/_states.dart';
import '../../ui_kit/_ui_kit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Consumer<StickerProvider>(
            builder: (context, provider, _) {
              return SwitchListTile(
                title: Text(
                  provider.light ? 'Light theme' : 'Dark theme',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                value: provider.light,
                onChanged: (_) => provider.toggleTheme(),
              );
            },
          ),
        ],
      ),
    );
  }
}
