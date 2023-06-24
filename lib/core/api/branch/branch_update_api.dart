import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class BranchUpdateApi {
  Future branchUpdateApi({int? branchID , String? name, int? companyID}) async {
   String subUrl = "/api/company/$companyID/branch/";
   String uri = AppAPI.baseUrl + subUrl;
    final bodyData =json.encode({
      "company":companyID,
      "name":name
    });

    final response = await Api().dio.put(
      uri,
      data: bodyData,
      queryParameters: {
        "branch_id":branchID
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