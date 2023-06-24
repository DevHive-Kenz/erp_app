import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../constants/api_const/api_const.dart';
import '../../../interceptor/app_dio.dart';



class VehicleUpdateApi {
  Future vehicleUpdateApi(   {required int companyID,
    required String model,
    required String name,
    required String numberPlate,
    required int branchID,
    required int year, required int vehicleID}) async {
    String subUrl = "/api/company/$companyID/branch/$branchID/vehicle/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData = json.encode({
      "company": companyID,
      "branch": branchID,
      "name": name,
      "number_plate": numberPlate,
      "model": model,
      "year": year,
    });

    final response = await Api().dio.put(
      uri,
      data: bodyData,
      queryParameters: {
        "vehicle_id":vehicleID
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