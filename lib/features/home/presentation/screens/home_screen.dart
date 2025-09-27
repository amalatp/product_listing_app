import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/components/default_app_bar.dart';
import 'package:product_listing_app/configs/extension/mediaquery_extension.dart';
import 'package:product_listing_app/features/home/bloc/product_bloc.dart';
import 'package:product_listing_app/features/home/presentation/widgets/cart_button_widget.dart';
import 'package:product_listing_app/features/home/presentation/widgets/products_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = context.mediaQueryHeight;
    double width = context.mediaQueryWidth;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              isLeading: false,
              title: "Popular Products",
              action: CartButtonWidget(height: height, width: width),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: height * 0.02)),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ProductsListWidget(),
                      ),
                    ]),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: height * 0.07)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
