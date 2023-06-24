import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class CompanyUpdateApi {
  Future companyUpdateApi({int? user , String? name, int? companyID}) async {
    const String subUrl = "/api/company/";
    const String uri = AppAPI.baseUrl + subUrl;
    final bodyData =json.encode({
      "user":user,
      "name":name
    });

    final response = await Api().dio.put(
      uri,
      data: bodyData,
      queryParameters: {
        "company_id":companyID
      },
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