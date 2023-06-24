import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../constants/api_const/api_const.dart';
import '../../../../interceptor/app_dio.dart';



class CompanyDocumentUpdateApi {
  Future companyDocumentUpdateApi(
      {required int companyID,
        required int branchID,
        required int documentId,
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


    final response = await Api().dio.put(
      uri,
      data: bodyData,
      queryParameters: {
        "document_id":documentId
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