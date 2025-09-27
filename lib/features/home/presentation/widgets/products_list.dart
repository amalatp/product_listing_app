import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/extension/mediaquery_extension.dart';
import 'package:product_listing_app/features/home/bloc/product_bloc.dart';
import 'package:product_listing_app/features/home/presentation/widgets/product_card.dart';
import 'package:product_listing_app/features/home/presentation/widgets/products_skeletonizer.dart';

class ProductsListWidget extends StatelessWidget {
  const ProductsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = context.mediaQueryHeight;
    double width = context.mediaQueryWidth;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return ProductCardSkeleton(width: width, height: height);
        } else if (state is ProductSuccess) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .72,
              crossAxisSpacing: width * 0.04,
              mainAxisSpacing: height * 0.02,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products.elementAt(index);
              return ProductCard(
                product: product,
                width: width,
                height: height,
              );
            },
          );
        } else if (state is ProductError) {
          return const Text("Oops! Something went wrong");
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
