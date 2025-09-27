part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

class HomeInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;

  ProductSuccess({required this.products});
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});
}
