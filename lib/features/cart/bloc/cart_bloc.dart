import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/features/cart/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString('cart_items');
    if (cartJson != null) {
      final cartItems = CartItem.decode(cartJson);
      emit(CartLoaded(items: cartItems));
    } else {
      emit(CartLoaded(items: []));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    List<CartItem> currentItems = [];
    if (state is CartLoaded) {
      currentItems = List.from((state as CartLoaded).items);
    }

    final index = currentItems.indexWhere(
      (i) => i.product.id == event.item.product.id,
    );
    if (index >= 0) {
      currentItems[index] = CartItem(
        product: currentItems[index].product,
        quantity: currentItems[index].quantity + 1,
      );
    } else {
      currentItems.add(event.item);
    }

    await prefs.setString('cart_items', CartItem.encode(currentItems));
    emit(CartLoaded(items: currentItems));
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    if (state is CartLoaded) {
      final currentItems = List<CartItem>.from((state as CartLoaded).items);

      final index = currentItems.indexWhere(
        (i) => i.product.id == event.item.product.id,
      );

      if (index >= 0) {
        if (currentItems[index].quantity > 1) {
          currentItems[index] = CartItem(
            product: currentItems[index].product,
            quantity: currentItems[index].quantity - 1,
          );
        } else {
          currentItems.removeAt(index);
        }
      }

      await prefs.setString('cart_items', CartItem.encode(currentItems));
      emit(CartLoaded(items: currentItems));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('cart_items');
    emit(CartLoaded(items: []));
  }
}
