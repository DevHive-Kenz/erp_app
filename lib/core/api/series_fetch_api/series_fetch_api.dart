import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class SeriesFetchApi {
  Future seriesFetch({required String type}) async {
    const String subUrl = "/api/common/get_number";
    String uri = AppAPI.baseUrl + subUrl;
    final response = await Api().dio.get(
      uri,
      queryParameters: {
        "name":type
      },
    );
    final statusCode = response.statusCode;
    final body = response.data;
    if (statusCode == 201 || statusCode == 200) {
      return body;
    }
  }
}