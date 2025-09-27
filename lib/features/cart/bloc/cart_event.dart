part of 'cart_bloc.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;
  AddToCart(this.item);
}

class RemoveFromCart extends CartEvent {
  final CartItem item;
  RemoveFromCart(this.item);
}

class ClearCart extends CartEvent {}
