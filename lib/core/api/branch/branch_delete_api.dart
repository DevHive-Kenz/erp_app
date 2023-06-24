import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class BranchDeleteApi {
  Future branchDeleteApi({required int branchID,required int companyID}) async {
     String subUrl = "/api/company/$companyID/branch/";
     String uri = AppAPI.baseUrl + subUrl;
    final response = await Api().dio.delete(
      uri,
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