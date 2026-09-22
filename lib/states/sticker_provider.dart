import 'package:flutter/foundation.dart';

import '../data/_data.dart';
import 'sticker_state.dart';

class StickerProvider extends ChangeNotifier {
  StickerState _state = StickerState.initial();

  StickerState get state => _state;

  List<StickerCategory> get categories => _state.categories;
  List<Sticker> get stickers => _state.stickers;
  List<Sticker> get stickersByCategory => _state.stickersByCategory;
  List<Sticker> get cart => _state.cart;
  List<Sticker> get favorite => _state.favorite;
  bool get light => _state.light;
  double get subtotal => _state.subtotal;
  double get total => _state.total;

  Sticker getStickerById(int stickerId) => _state.getStickerById(stickerId);

  String stickerPrice(Sticker sticker) => _state.stickerPrice(sticker);

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

  void _setStickers(List<Sticker> stickers, {List<StickerCategory>? categories}) {
    final nextCategories = categories ?? _state.categories;
    _state = _state.copyWith(
      categories: nextCategories,
      stickers: stickers,
      stickersByCategory: _byCategory(stickers, nextCategories),
      cart: stickers.where((e) => e.cart).toList(),
      favorite: stickers.where((e) => e.favorite).toList(),
    );
    notifyListeners();
  }

  void onCategoryTap(StickerCategory category) {
    final categories = _state.categories.map((e) {
      if (e.type == category.type) {
        return e.copyWith(isSelected: true);
      }
      return e.copyWith(isSelected: false);
    }).toList();
    _setStickers(_state.stickers, categories: categories);
  }

  void onIncreaseQuantityTap(int stickerId) {
    final stickers = _state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(quantity: e.quantity + 1);
      }
      return e;
    }).toList();
    _setStickers(stickers);
  }

  void onDecreaseQuantityTap(int stickerId) {
    final stickers = _state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.quantity == 1 ? e : e.copyWith(quantity: e.quantity - 1);
      }
      return e;
    }).toList();
    _setStickers(stickers);
  }

  void onAddToCartTap(int stickerId) {
    final stickers = _state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(cart: true);
      }
      return e;
    }).toList();
    _setStickers(stickers);
  }

  void onRemoveFromCartTap(int stickerId) {
    final stickers = _state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();
    _setStickers(stickers);
  }

  void onCheckOutTap() {
    final cartIds = _state.cart.map((e) => e.id).toSet();
    final stickers = _state.stickers.map((e) {
      if (cartIds.contains(e.id)) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();
    _setStickers(stickers);
  }

  void onAddRemoveFavoriteTap(int stickerId) {
    final stickers = _state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(favorite: !e.favorite);
      }
      return e;
    }).toList();
    _setStickers(stickers);
  }

  void toggleTheme() {
    _state = _state.copyWith(light: !_state.light);
    notifyListeners();
  }

  // 14 шагов логики
  // 1.  Подсветка выбранной категории
  // 2.  Продукты по категории
  // 3.  Детали: отображение продукта
  // 4.  Детали: количество
  // 5.  Корзина: управление пустой корзиной
  // 6.  Детали: добавление в корзину
  // 7.  Корзина: список в корзине
  // 8.  Корзина: стоимость корзины
  // 9.  Корзина: количество
  // 10. Корзина: удаление
  // 11. Корзина: чистка корзина на checkout
  // 12. Любимые: управление пустым экраном
  // 13. Детали: Добавление/удаление любимые
  // 14. Смена темы
}
