import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/features/home/data/repository/home_repository.dart';
import 'package:product_listing_app/features/home/models/pduct_model.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final HomeRepository homeRepository;
  ProductBloc(this.homeRepository) : super(HomeInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await homeRepository.getProductList();
      emit(ProductSuccess(products: products));
    } catch (e) {
      log("error from home bloc $e");
      emit(ProductError(message: "Failed to fetch products: $e"));
    }
  }
}
