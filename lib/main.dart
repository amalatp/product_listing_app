import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/configs/Routes/route_generator.dart';
import 'package:product_listing_app/configs/Routes/routes_name.dart';
import 'package:product_listing_app/features/cart/bloc/cart_bloc.dart';
import 'package:product_listing_app/features/home/bloc/product_bloc.dart';
import 'package:product_listing_app/features/home/data/data_provider/home_data_provider.dart';
import 'package:product_listing_app/features/home/data/repository/home_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(HomeRepository(HomeDataProvider())),
        ),
        BlocProvider(create: (context) => CartBloc()..add(LoadCart())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        title: 'Shopping App',
        initialRoute: RoutesName.home,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
