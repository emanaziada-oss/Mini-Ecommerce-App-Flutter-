import 'package:bloc/bloc.dart';
import 'package:myproject/features/fav/model/fav_model.dart';
import '../model/cart_model.dart';
import 'cart_state.dart';
import 'package:hive/hive.dart';


class CartCubit extends Cubit<CartState> {
  final Box<CartItem> _cartBox;
  CartCubit(this._cartBox) : super(CartInitial());

  // Load cart items from Hive
  Future<void> loadCart() async{
    await Future.delayed(const Duration(seconds: 1)).then((e){
      final cartItems = _cartBox.values.toList();
      emit(CartLoaded(cartItems));
    });
  }

  // Add item to cart without quantity
  Future<void> addToCart(CartItem item) async {
    if(!_cartBox.containsKey(item.productId)){
      await _cartBox.put(item.productId, item);
    }
    final items = _cartBox.values.toList();
    emit(CartLoaded(items));
  }

  // Add item to cart without quantity
  Future<void> addFavToCart(FavItem item) async {
    final productId = item.productId;
    if(!_cartBox.containsKey(productId)){
      final newCartItem = CartItem(
        productId: productId,
        title: item.title,
        price: item.price,
        quantity: 1,
        thumbnail: item.thumbnail,
        stock: item.stock,
      );
      await _cartBox.put(productId, newCartItem);
    }
    final items = _cartBox.values.toList();
    emit(CartLoaded(items));
  }
  // Update quantity
  Future <void> updateQuantity(int productId, int newQuantity) async {
    if(_cartBox.containsKey(productId)){
      final item = _cartBox.get(productId);
      item?.quantity = newQuantity;
      await item?.save();
      final items = _cartBox.values.toList();
      emit(CartLoaded(items));
    }
  }

  //Remove item
  Future<void> removeFromCart(int productId) async {
    await _cartBox.delete(productId);
    final items = _cartBox.values.toList();
    emit(CartLoaded(items));
  }

  // Clear cart
  Future<void> clearCart() async {
    await _cartBox.clear();
    emit(CartLoaded(_cartBox.values.toList()));
  }

  // Total price
  double get total {
    return _cartBox.values.fold(0, (total, item) => total + item.price * item.quantity);
  }

  bool contains(int productId) {
    return _cartBox.containsKey(productId);
  }

}

