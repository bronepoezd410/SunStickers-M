import '../data/_data.dart';

class CategoryTappedAction {
  const CategoryTappedAction(this.category);
  final StickerCategory category;
}

class QuantityIncreasedAction {
  const QuantityIncreasedAction(this.stickerId);
  final int stickerId;
}

class QuantityDecreasedAction {
  const QuantityDecreasedAction(this.stickerId);
  final int stickerId;
}

class AddedToCartAction {
  const AddedToCartAction(this.stickerId);
  final int stickerId;
}

class RemovedFromCartAction {
  const RemovedFromCartAction(this.stickerId);
  final int stickerId;
}

class CheckoutTappedAction {
  const CheckoutTappedAction();
}

class FavoriteToggledAction {
  const FavoriteToggledAction(this.stickerId);
  final int stickerId;
}

class ThemeToggledAction {
  const ThemeToggledAction();
}
