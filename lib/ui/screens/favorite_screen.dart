import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../data/_data.dart';
import '../../states/_states.dart';
import '../../ui_kit/_ui_kit.dart';
import '../_ui.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<StickerStore>();
    return Scaffold(
      appBar: _appBar(context),
      body: Observer(
        builder: (_) {
          store.version.value;
          return EmptyWrapper(
            type: EmptyWrapperType.favorite,
            title: "Empty favorite",
            isEmpty: store.favorite.isEmpty,
            child: _favoriteListView(context, store),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Favorite screen",
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }

  Widget _favoriteListView(BuildContext context, StickerStore store) {
    return ListView.separated(
      padding: const EdgeInsets.all(30),
      itemCount: store.favorite.length,
      itemBuilder: (_, index) {
        final Sticker sticker = store.favorite[index];
        return Card(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : AppColor.dark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text(
              sticker.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: Image.asset(sticker.image),
            subtitle: Text(
              sticker.description,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: IconButton(
              icon: const Icon(AppIcon.heart, color: Colors.redAccent),
              onPressed: () => store.onAddRemoveFavoriteTap(sticker),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => Container(
        height: 20,
      ),
    );
  }
}
