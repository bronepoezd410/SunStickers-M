import '../data/_data.dart';
import 'sticker_actions.dart';
import 'sticker_state.dart';

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

StickerState _withStickers(
  StickerState state,
  List<Sticker> stickers, {
  List<StickerCategory>? categories,
}) {
  final nextCategories = categories ?? state.categories;
  return state.copyWith(
    categories: nextCategories,
    stickers: stickers,
    stickersByCategory: _byCategory(stickers, nextCategories),
    cart: stickers.where((e) => e.cart).toList(),
    favorite: stickers.where((e) => e.favorite).toList(),
  );
}

StickerState stickerReducer(StickerState state, dynamic action) {
  if (action is CategoryTappedAction) {
    final categories = state.categories.map((e) {
      if (e.type == action.category.type) {
        return e.copyWith(isSelected: true);
      }
      return e.copyWith(isSelected: false);
    }).toList();
    return _withStickers(state, state.stickers, categories: categories);
  }

  if (action is QuantityIncreasedAction) {
    final stickers = state.stickers.map((e) {
      if (e.id == action.stickerId) {
        return e.copyWith(quantity: e.quantity + 1);
      }
      return e;
    }).toList();
    return _withStickers(state, stickers);
  }

  if (action is QuantityDecreasedAction) {
    final stickers = state.stickers.map((e) {
      if (e.id == action.stickerId) {
        return e.quantity == 1 ? e : e.copyWith(quantity: e.quantity - 1);
      }
      return e;
    }).toList();
    return _withStickers(state, stickers);
  }

  if (action is AddedToCartAction) {
    final stickers = state.stickers.map((e) {
      if (e.id == action.stickerId) {
        return e.copyWith(cart: true);
      }
      return e;
    }).toList();
    return _withStickers(state, stickers);
  }

  if (action is RemovedFromCartAction) {
    final stickers = state.stickers.map((e) {
      if (e.id == action.stickerId) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();
    return _withStickers(state, stickers);
  }

  if (action is CheckoutTappedAction) {
    final cartIds = state.cart.map((e) => e.id).toSet();
    final stickers = state.stickers.map((e) {
      if (cartIds.contains(e.id)) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();
    return _withStickers(state, stickers);
  }

  if (action is FavoriteToggledAction) {
    final stickers = state.stickers.map((e) {
      if (e.id == action.stickerId) {
        return e.copyWith(favorite: !e.favorite);
      }
      return e;
    }).toList();
    return _withStickers(state, stickers);
  }

  if (action is ThemeToggledAction) {
    return state.copyWith(light: !state.light);
  }

  return state;
}
