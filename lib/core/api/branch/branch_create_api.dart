import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class BranchCreateApi {
  Future branchCreateApi({required int? companyID , required String? name}) async {
    String subUrl = "/api/company/$companyID/branch/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData =json.encode({
      "company":companyID,
      "name":name
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