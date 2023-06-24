import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../constants/api_const/api_const.dart';
import '../../../../interceptor/app_dio.dart';


class VehicleDocumentDeleteApi {
  Future vehicleDocumentDeleteApi({required int companyID,required int branchID,required int documentId,required int vehicleID}) async {
    String subUrl = "/api/company/$companyID/branch/$branchID/vehicle/$vehicleID/document/";
    String uri = AppAPI.baseUrl + subUrl;
    final response = await Api().dio.delete(
      uri,
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