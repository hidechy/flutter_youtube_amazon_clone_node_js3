// ignore_for_file: use_build_context_synchronously, avoid_dynamic_calls, avoid_catches_without_on_clauses

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../constants/error_handling.dart';
import '../../constants/global_variables.dart';
import '../../constants/utils.dart';
import '../../providers/user_provider.dart';

class AddressService {
  ///
  Future<void> saveUserAddress({required BuildContext context, required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': userProvider.user.token},
        body: jsonEncode({'userId': userProvider.user.id, 'address': address}),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final user = userProvider.user.copyWith(address: jsonDecode(res.body)['address']);

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  ///
// Future<void> placeOrder({required BuildContext context, required String address, required double totalSum}) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//
//   try {
//     final res = await http.post(
//       Uri.parse('$uri/api/order'),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'x-auth-token': userProvider.user.token,
//       },
//       body: jsonEncode({'cart': userProvider.user.cart, 'address': address, 'totalPrice': totalSum}),
//     );
//
//     httpErrorHandle(
//       response: res,
//       context: context,
//       onSuccess: () {
//         showSnackBar(context, 'Your order has been placed!');
//         final user = userProvider.user.copyWith(cart: []);
//
//         userProvider.setUserFromModel(user);
//       },
//     );
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }
// }

  ///
// Future<void> deleteProduct(
//     {required BuildContext context, required Product product, required VoidCallback onSuccess}) async {
//   final userProvider = Provider.of<UserProvider>(context, listen: false);
//
//   try {
//     final res = await http.post(
//       Uri.parse('$uri/admin/delete-product'),
//       headers: {'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': userProvider.user.token},
//       body: jsonEncode({'id': product.id}),
//     );
//
//     httpErrorHandle(
//       response: res,
//       context: context,
//       onSuccess: () => onSuccess(),
//     );
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }
// }
}
