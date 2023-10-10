// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';

import 'common/bottom_bar.dart';

import 'features/address/address_screen.dart';
import 'features/admin/add_product_screen.dart';
import 'features/admin/admin_screen.dart';
import 'features/auth/auth_screen.dart';
import 'features/home/category_deals_screen.dart';
import 'features/home/home_screen.dart';
import 'features/product_detail/product_detail_screen.dart';
import 'features/search/search_screen.dart';
import 'models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const BottomBar(),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AdminScreen(),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      final category = routeSettings.arguments as String;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(category: category),
      );

    case SearchScreen.routeName:
      final searchQuery = routeSettings.arguments as String;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery),
      );

    case ProductDetailScreen.routeName:
      final product = routeSettings.arguments as Product;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(product: product),
      );

    case AddressScreen.routeName:
      final totalAmount = routeSettings.arguments as String;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(totalAmount: totalAmount),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Screen does not exists.'),
          ),
        ),
      );
  }
}
