import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class LogInAPI {
  Future login({required String userName , required String password,required String deviceToken}) async {
    const String subUrl = "/api/login/";
    const String uri = AppAPI.baseUrl + subUrl;
    final bodyData =json.encode({
      "email":userName,
      "password":password,
      "device_token":deviceToken
    });
    final response = await Api().dio.post(
      uri,
      data: bodyData,
      options: Options(
        headers: {"accept": "*/*"},
        contentType: "application/json",
      ),
    );
    final statusCode = response.statusCode;
    final body = response.data;
    if (statusCode == 201 || statusCode == 200) {
      return body;
    }
  }
}