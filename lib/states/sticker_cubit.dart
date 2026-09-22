import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/_data.dart';
import 'sticker_state.dart';

class StickerCubit extends Cubit<StickerState> {
  StickerCubit() : super(StickerState.initial());

  List<Sticker> _byCategory(List<Sticker> stickers, List<StickerCategory> categories) {
    final selected = categories.firstWhere(
      (e) => e.isSelected,
      orElse: () => categories.first,
    );
    if (selected.type == StickerType.all) {
      return List<Sticker>.from(stickers);
    }
    return stickers.where((e) => e.type == selected.type).toList();
  }

  StickerState _withStickers(List<Sticker> stickers, {List<StickerCategory>? categories}) {
    final nextCategories = categories ?? state.categories;
    return state.copyWith(
      categories: nextCategories,
      stickers: stickers,
      stickersByCategory: _byCategory(stickers, nextCategories),
      cart: stickers.where((e) => e.cart).toList(),
      favorite: stickers.where((e) => e.favorite).toList(),
    );
  }

  void onCategoryTap(StickerCategory category) {
    final categories = state.categories.map((e) {
      if (e.type == category.type) {
        return e.copyWith(isSelected: true);
      }
      return e.copyWith(isSelected: false);
    }).toList();
    emit(_withStickers(state.stickers, categories: categories));
  }

  void onIncreaseQuantityTap(int stickerId) {
    final stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(quantity: e.quantity + 1);
      }
      return e;
    }).toList();
    emit(_withStickers(stickers));
  }

  void onDecreaseQuantityTap(int stickerId) {
    final stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.quantity == 1 ? e : e.copyWith(quantity: e.quantity - 1);
      }
      return e;
    }).toList();
    emit(_withStickers(stickers));
  }

  void onAddToCartTap(int stickerId) {
    final stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(cart: true);
      }
      return e;
    }).toList();
    emit(_withStickers(stickers));
  }

  void onRemoveFromCartTap(int stickerId) {
    final stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();
    emit(_withStickers(stickers));
  }

  void onCheckOutTap() {
    final cartIds = state.cart.map((e) => e.id).toSet();
    final stickers = state.stickers.map((e) {
      if (cartIds.contains(e.id)) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();
    emit(_withStickers(stickers));
  }

  void onAddRemoveFavoriteTap(int stickerId) {
    final stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(favorite: !e.favorite);
      }
      return e;
    }).toList();
    emit(_withStickers(stickers));
  }

  void toggleTheme() {
    emit(state.copyWith(light: !state.light));
  }
}
