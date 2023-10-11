// ignore_for_file: use_build_context_synchronously, avoid_catches_without_on_clauses, avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../constants/error_handling.dart';
import '../../constants/global_variables.dart';
import '../../constants/utils.dart';
import '../../models/order.dart';
import '../../models/product.dart';
import '../../providers/user_provider.dart';

class AdminService {
  ///
  Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('drojb2krn', 'e5r9mcrc');

      final imageUrls = <String>[];
      for (var i = 0; i < images.length; i++) {
        final res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );

        imageUrls.add(res.secureUrl);
      }

      final product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      final res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': userProvider.user.token},
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  ///
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final productList = <Product>[];

    try {
      final res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }

  ///
  Future<void> deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () => onSuccess(),
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  ///
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final orderList = <Order>[];

    try {
      final res = await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: {'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': userProvider.user.token},
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return orderList;
  }

  ///
  Future<void> changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': userProvider.user.token},
        body: jsonEncode({'id': order.id, 'status': status}),
      );

      httpErrorHandle(response: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
