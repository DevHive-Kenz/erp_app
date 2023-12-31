import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../constants/api_const/api_const.dart';
import '../../../interceptor/app_dio.dart';

class SalesReturnByIdApi {
  Future salesReturnById({required String invoiceNumber}) async {
    const String subUrl = "/api/sales/get";
    // const String subUrl = "/api/sales";
    String uri = AppAPI.baseUrl + subUrl;
    final response = await Api().dio.get(
        uri,
        queryParameters: {
          "invoice_number":invoiceNumber
        },
    );
    final statusCode = response.statusCode;
    final body = response.data;
    if (statusCode == 201 || statusCode == 200) {
      return body;
    }
  }
}