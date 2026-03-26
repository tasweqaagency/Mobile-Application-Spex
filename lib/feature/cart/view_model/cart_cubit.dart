import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<CartItem> _cartItems = [];

  void addToCart(CartItem newItem) {
    emit(CartLoading());
    
    // Check if item with same productId AND variationId AND size AND color already exists
    int existingIndex = _cartItems.indexWhere((item) => 
      item.productId == newItem.productId && 
      item.variationId == newItem.variationId &&
      item.selectedSize == newItem.selectedSize &&
      item.selectedColor == newItem.selectedColor
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += newItem.quantity;
    } else {
      _cartItems.add(newItem);
    }

    emit(CartUpdated(List.from(_cartItems)));
  }

  void removeFromCart(int productId, {int? variationId, String? selectedSize, String? selectedColor}) {
    emit(CartLoading());
    _cartItems.removeWhere((item) => 
      item.productId == productId && 
      item.variationId == variationId &&
      item.selectedSize == selectedSize &&
      item.selectedColor == selectedColor
    );
    emit(CartUpdated(List.from(_cartItems)));
  }

  void incrementQuantity(int productId, {int? variationId, String? selectedSize, String? selectedColor}) {
    int index = _cartItems.indexWhere((item) => 
      item.productId == productId && 
      item.variationId == variationId &&
      item.selectedSize == selectedSize &&
      item.selectedColor == selectedColor
    );
    if (index != -1) {
      emit(CartLoading());
      _cartItems[index].quantity++;
      emit(CartUpdated(List.from(_cartItems)));
    }
  }

  void decrementQuantity(int productId, {int? variationId, String? selectedSize, String? selectedColor}) {
    int index = _cartItems.indexWhere((item) => 
      item.productId == productId && 
      item.variationId == variationId &&
      item.selectedSize == selectedSize &&
      item.selectedColor == selectedColor
    );
    if (index != -1 && _cartItems[index].quantity > 1) {
      emit(CartLoading());
      _cartItems[index].quantity--;
      emit(CartUpdated(List.from(_cartItems)));
    } else if (index != -1 && _cartItems[index].quantity == 1) {
      removeFromCart(productId, variationId: variationId, selectedSize: selectedSize, selectedColor: selectedColor);
    }
  }

  void clearCart() {
    emit(CartLoading());
    _cartItems = [];
    emit(CartUpdated([]));
  }

  double get totalPrice {
    return _cartItems.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  int get itemCount {
    return _cartItems.fold(0, (total, item) => total + item.quantity);
  }
}
