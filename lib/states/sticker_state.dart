import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/_data.dart';

class StickerState extends GetxController {
  // Переменные
  final categories = <StickerCategory>[].obs;
  final stickers = <Sticker>[].obs;
  final stickersByCategory = <Sticker>[].obs;
  final cart = <Sticker>[].obs;
  final favorite = <Sticker>[].obs;
  final light = true.obs;

  static const double taxes = 5.0;

  @override
  void onInit() {
    super.onInit();
    categories.assignAll(AppData.categories);
    stickers.assignAll(AppData.stickers);
    stickersByCategory.assignAll(AppData.stickers);
  }

  // Действия
  Future<void> onCategoryTap(StickerCategory category) async {
    for (final e in categories) {
      e.isSelected = e.type == category.type;
    }
    if (category.type == StickerType.all) {
      stickersByCategory.assignAll(stickers);
    } else {
      stickersByCategory.assignAll(
        stickers.where((e) => e.type == category.type).toList(),
      );
    }
    categories.refresh();
  }

  Future<void> onIncreaseQuantityTap(Sticker sticker) async {
    sticker.quantity++;
    stickers.refresh();
    stickersByCategory.refresh();
    cart.refresh();
  }

  Future<void> onDecreaseQuantityTap(Sticker sticker) async {
    if (sticker.quantity == 1) return;
    sticker.quantity--;
    stickers.refresh();
    stickersByCategory.refresh();
    cart.refresh();
  }

  Future<void> onAddToCartTap(Sticker sticker) async {
    sticker.cart = true;
    cart.assignAll(stickers.where((e) => e.cart).toList());
    stickers.refresh();
  }

  Future<void> onRemoveFromCartTap(Sticker sticker) async {
    sticker.cart = false;
    sticker.quantity = 1;
    cart.assignAll(stickers.where((e) => e.cart).toList());
    stickers.refresh();
  }

  Future<void> onCheckOutTap() async {
    for (final e in cart) {
      e.cart = false;
      e.quantity = 1;
    }
    cart.assignAll(stickers.where((e) => e.cart).toList());
    stickers.refresh();
  }

  Future<void> onAddRemoveFavoriteTap(Sticker sticker) async {
    sticker.favorite = !sticker.favorite;
    favorite.assignAll(stickers.where((e) => e.favorite).toList());
    stickers.refresh();
    stickersByCategory.refresh();
  }

  void toggleTheme() {
    light.value = !light.value;
    Get.changeThemeMode(light.value ? ThemeMode.light : ThemeMode.dark);
  }

  // Вспомогательные методы
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
