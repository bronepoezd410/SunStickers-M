import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../states/_states.dart';
import '../../ui_kit/_ui_kit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<StickerState>();
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
          Obx(
            () => SwitchListTile(
              title: Text(
                state.light.value ? 'Light theme' : 'Dark theme',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              value: state.light.value,
              onChanged: (_) => state.toggleTheme(),
            ),
          ),
        ],
      ),
    );
  }
}
