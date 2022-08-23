import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app/app.dart';
import 'package:schedule_app/common/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final options = BaseOptions(
    baseUrl: AppConfig.apiBaseUrl,
    connectTimeout: 15000,
    receiveTimeout: 3000,
    headers: {
      'content-Type': 'application/json',
      'authorization': 'Bearer $token'
    },
  );
  final httpClient = Dio(options);

  runApp(App(httpClient: httpClient));
}
