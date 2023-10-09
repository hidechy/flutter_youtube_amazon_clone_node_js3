// ignore_for_file: use_build_context_synchronously, avoid_catches_without_on_clauses

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../constants/error_handling.dart';
import '../../constants/global_variables.dart';
import '../../constants/utils.dart';
import '../../models/user.dart';

class AuthService {
  ///
  Future<void> signUpUser(
      {required BuildContext context, required String email, required String password, required String name}) async {
    try {
      final user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      final res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created!!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
