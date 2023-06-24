import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../constants/api_const/api_const.dart';
import '../../../../interceptor/app_dio.dart';

class EmployeeDocumentCreateApi {
  Future employeeDocumentCreateApi(
      {required int companyID,
      required int branchID,
      required int employeeID,
      required String documentType,
      required String documentNo,
      required String expiry,

      }) async {
    String subUrl = "/api/company/$companyID/branch/$branchID/employee/$employeeID/document/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData = json.encode({
      "company": companyID,
      "branch": branchID,
      "employee": employeeID,
      "document_type": documentType,
      "expiry": expiry,
      "document_number":documentNo
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
