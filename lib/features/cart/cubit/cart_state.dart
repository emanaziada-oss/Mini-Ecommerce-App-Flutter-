
import '../model/cart_model.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoaded extends CartState{
  List<CartItem> items;
  CartLoaded(this.items);

  double get total => items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
}