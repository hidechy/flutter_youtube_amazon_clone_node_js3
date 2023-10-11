// ignore_for_file: use_build_context_synchronously, avoid_dynamic_calls, avoid_catches_without_on_clauses

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../constants/error_handling.dart';
import '../../constants/global_variables.dart';
import '../../constants/utils.dart';
import '../../models/order.dart';
import '../../providers/user_provider.dart';

class AccountService {
  ///
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final orderList = <Order>[];

    try {
      final res = await http.get(
        Uri.parse('$uri/api/orders/me/${userProvider.user.id}'),
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
// Future<void> logOut(BuildContext context) async {
//   try {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     await sharedPreferences.setString('x-auth-token', '');
//     await Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeName, (route) => false);
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }
// }
}
