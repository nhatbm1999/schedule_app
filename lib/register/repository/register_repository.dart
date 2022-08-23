import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:schedule_app/authentication/model/user.dart';

class RegisterRepository {
  const RegisterRepository({required this.httpClient});
  final Dio httpClient;

  Future<User> register({
    required String email,
    required String username,
    required String password,
    required String phone,
  }) async {
    final jsonResponse = await httpClient.post(
      '/register', data: {
        'email' : email,
        'username': username,
        'password': password,
        'phone': phone,
      }
    );
    return User.fromJson(jsonResponse.data);
  }
}