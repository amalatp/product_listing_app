import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/helpers/db_helper.dart';
import 'package:product_listing_app/features/cart/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartDatabase db = CartDatabase.instance;

  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    final cartItems = await db.fetchCart();
    emit(CartLoaded(items: cartItems));
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    List<CartItem> currentItems = [];
    if (state is CartLoaded) {
      currentItems = List.from((state as CartLoaded).items);
    }

    final index = currentItems.indexWhere(
      (i) => i.product.id == event.item.product.id,
    );

    if (index >= 0) {
      final updatedItem = CartItem(
        product: currentItems[index].product,
        quantity: currentItems[index].quantity + 1,
      );
      await db.updateItem(updatedItem);
    } else {
      await db.insertItem(event.item);
    }

    final cartItems = await db.fetchCart();
    emit(CartLoaded(items: cartItems));
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    if (state is CartLoaded) {
      final currentItems = List<CartItem>.from((state as CartLoaded).items);
      final index = currentItems.indexWhere(
        (i) => i.product.id == event.item.product.id,
      );

      if (index >= 0) {
        if (currentItems[index].quantity > 1) {
          final updatedItem = CartItem(
            product: currentItems[index].product,
            quantity: currentItems[index].quantity - 1,
          );
          await db.updateItem(updatedItem);
        } else {
          await db.deleteItem(event.item.product.id!);
        }
      }

      final cartItems = await db.fetchCart();
      emit(CartLoaded(items: cartItems));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    await db.clearCart();
    emit(CartLoaded(items: []));
  }
}
