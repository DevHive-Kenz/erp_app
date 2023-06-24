import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../constants/api_const/api_const.dart';
import '../../../../interceptor/app_dio.dart';



class VehicleDocumentUpdateApi {
  Future vehicleDocumentUpdateApi(
      {required int companyID,
        required int branchID,
        required int vehicleID,
        required int documentId,
        required String documentType,
        required String documentNo,
        required String expiry,

      }) async {
    String subUrl = "/api/company/$companyID/branch/$branchID/vehicle/$vehicleID/document/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData = json.encode({
      "company": companyID,
      "branch": branchID,
      "vehicle": vehicleID,
      "document_type": documentType,
      "expiry": expiry,
      "document_number":documentNo
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