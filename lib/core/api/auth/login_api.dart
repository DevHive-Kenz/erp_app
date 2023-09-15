import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class LoginAPI {
  Future loginUser({required String email, required String pass, required String token}) async {
    const String subUrl = "/api/login/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData = json.encode({
      "email":email,
      "password":pass,
      "device_token":token
    });
    final response = await Api().dio.post(
        uri,
        data: bodyData
    );
    final statusCode = response.statusCode;
    final body = response.data;
    if (statusCode == 201 || statusCode == 200) {
      return body;
    }
  }
}