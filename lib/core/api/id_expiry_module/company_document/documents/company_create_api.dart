import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../constants/api_const/api_const.dart';
import '../../../../interceptor/app_dio.dart';

class CompanyDocumentCreateApi {
  Future companyDocumentCreateApi(
      {required int companyID,
      required int branchID,
      required String expiry,
      required String documentType,
      required String documentNumber,
      }) async {
    String subUrl = "/api/company/$companyID/branch/$branchID/document/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData = json.encode({
      "company": companyID,
      "branch": branchID,
      "document_type": documentType,
      "document_number": documentNumber,
      "expiry": expiry,
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
