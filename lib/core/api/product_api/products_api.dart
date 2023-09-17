import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class ProductsApi {
  Future product() async {
    const String subUrl = "/api/product";
    String uri = AppAPI.baseUrl + subUrl;
    final response = await Api().dio.get(uri);
    final statusCode = response.statusCode;
    final body = response.data;
    if (statusCode == 201 || statusCode == 200) {
      return body;
    }
  }
}