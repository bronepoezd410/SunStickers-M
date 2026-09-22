import 'package:equatable/equatable.dart';

import '../data/_data.dart';

class StickerState extends Equatable {
  const StickerState({
    required this.categories,
    required this.stickers,
    required this.stickersByCategory,
    required this.cart,
    required this.favorite,
    required this.light,
  });

  factory StickerState.initial() {
    return StickerState(
      categories: List<StickerCategory>.from(AppData.categories),
      stickers: List<Sticker>.from(AppData.stickers),
      stickersByCategory: List<Sticker>.from(AppData.stickers),
      cart: const <Sticker>[],
      favorite: const <Sticker>[],
      light: true,
    );
  }

  static const double taxes = 5.0;

  final List<StickerCategory> categories;
  final List<Sticker> stickers;
  final List<Sticker> stickersByCategory;
  final List<Sticker> cart;
  final List<Sticker> favorite;
  final bool light;

  Sticker getStickerById(int stickerId) {
    return stickers.firstWhere((e) => e.id == stickerId);
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

  StickerState copyWith({
    List<StickerCategory>? categories,
    List<Sticker>? stickers,
    List<Sticker>? stickersByCategory,
    List<Sticker>? cart,
    List<Sticker>? favorite,
    bool? light,
  }) {
    return StickerState(
      categories: categories ?? this.categories,
      stickers: stickers ?? this.stickers,
      stickersByCategory: stickersByCategory ?? this.stickersByCategory,
      cart: cart ?? this.cart,
      favorite: favorite ?? this.favorite,
      light: light ?? this.light,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        stickers,
        stickersByCategory,
        cart,
        favorite,
        light,
      ];

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
