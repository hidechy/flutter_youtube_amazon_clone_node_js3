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

class CartService {
  ///
  Future<void> removeFromCart({required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}/${userProvider.user.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final user = userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
