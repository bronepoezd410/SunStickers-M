import 'package:mobx/mobx.dart';

import '../data/_data.dart';

class StickerStore {
  StickerStore() {
    categories.addAll(AppData.categories);
    stickers.addAll(AppData.stickers);
    stickersByCategory.addAll(AppData.stickers);
  }

  static const double taxes = 5.0;

  final ObservableList<StickerCategory> categories = ObservableList<StickerCategory>();
  final ObservableList<Sticker> stickers = ObservableList<Sticker>();
  final ObservableList<Sticker> stickersByCategory = ObservableList<Sticker>();
  final ObservableList<Sticker> cart = ObservableList<Sticker>();
  final ObservableList<Sticker> favorite = ObservableList<Sticker>();
  final Observable<bool> light = Observable<bool>(true);

  /// Нужен, т.к. поля Sticker мутабельны и сами по себе не триггерят MobX.
  final Observable<int> version = Observable<int>(0);

  void _notify() {
    version.value = version.value + 1;
  }

  void onCategoryTap(StickerCategory category) {
    runInAction(() {
      for (final e in categories) {
        e.isSelected = e.type == category.type;
      }
      stickersByCategory
        ..clear()
        ..addAll(
          category.type == StickerType.all
              ? stickers
              : stickers.where((e) => e.type == category.type),
        );
      _notify();
    });
  }

  void onIncreaseQuantityTap(Sticker sticker) {
    runInAction(() {
      sticker.quantity++;
      _notify();
    });
  }

  void onDecreaseQuantityTap(Sticker sticker) {
    runInAction(() {
      if (sticker.quantity == 1) return;
      sticker.quantity--;
      _notify();
    });
  }

  void onAddToCartTap(Sticker sticker) {
    runInAction(() {
      sticker.cart = true;
      cart
        ..clear()
        ..addAll(stickers.where((e) => e.cart));
      _notify();
    });
  }

  void onRemoveFromCartTap(Sticker sticker) {
    runInAction(() {
      sticker.cart = false;
      sticker.quantity = 1;
      cart
        ..clear()
        ..addAll(stickers.where((e) => e.cart));
      _notify();
    });
  }

  void onCheckOutTap() {
    runInAction(() {
      for (final e in cart) {
        e.cart = false;
        e.quantity = 1;
      }
      cart
        ..clear()
        ..addAll(stickers.where((e) => e.cart));
      _notify();
    });
  }

  void onAddRemoveFavoriteTap(Sticker sticker) {
    runInAction(() {
      sticker.favorite = !sticker.favorite;
      favorite
        ..clear()
        ..addAll(stickers.where((e) => e.favorite));
      _notify();
    });
  }

  void toggleTheme() {
    runInAction(() {
      light.value = !light.value;
    });
  }

  String stickerPrice(Sticker sticker) {
    return (sticker.quantity * sticker.price).toStringAsFixed(0);
  }

  double get subtotal {
    double amount = 0.0;
    for (final e in cart) {
      amount = amount + e.price * e.quantity;
    }
    return amount;
  }

  double get total => subtotal + taxes;

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
