import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:schedule_app/authentication/model/user.dart';

class AccountRepository {
  const AccountRepository({required this.httpClient});

  //final FirebaseStorage storage = FirebaseStorage.instance;

  final Dio httpClient;

  Future<String> uploadAvatarFile(
      {required File avatarImage, required String fileName}) async {
    final path = 'avatar/$fileName';

    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadImage = ref.putFile(avatarImage);

    final snapshot = await uploadImage.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  Future<void> uploadAvatarInfo({
    required String userId,
    required String avatarImageUrl,
  }) async {
    final jsonResponse =
        await httpClient.patch('/updateInfo?id=$userId', data: {
      'avatar': avatarImageUrl,
    });
    return jsonResponse.data;
  }

  Future<User> getUserInfo({
    required String userId,
  }) async {
    final jsonResponse = await httpClient.get('/user?id=$userId');
    return User.fromJson(jsonResponse.data['data']);
  }

  Future<void> changeUserName({
    required String userId,
    required String userName,
  }) async {
    final jsonResponse =
        await httpClient.patch('/updateInfo?id=$userId', data: {
      'username': userName,
    });
    return jsonResponse.data;
  }
}
