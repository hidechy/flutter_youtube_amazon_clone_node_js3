// ignore_for_file: use_build_context_synchronously, avoid_dynamic_calls, avoid_catches_without_on_clauses

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../constants/error_handling.dart';
import '../../constants/global_variables.dart';
import '../../constants/utils.dart';
import '../../models/product.dart';
import '../../providers/user_provider.dart';

class HomeService {
  ///
  Future<List<Product>> fetchCategoryProducts({required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final productList = <Product>[];

    try {
      final res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
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
            productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }

//
//
//
// ///
// Future<Product> fetchDealOfDay({required BuildContext context}) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//
//   var product = Product(
//     name: '',
//     description: '',
//     quantity: 0,
//     images: [],
//     category: '',
//     price: 0,
//   );
//
//   try {
//     final res = await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'x-auth-token': userProvider.user.token,
//     });
//
//     httpErrorHandle(
//       response: res,
//       context: context,
//       onSuccess: () {
//         product = Product.fromJson(res.body);
//       },
//     );
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }
//   return product;
// }
//
//
//
//
}
