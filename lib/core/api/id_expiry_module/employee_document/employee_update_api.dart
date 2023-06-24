import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../constants/api_const/api_const.dart';
import '../../../interceptor/app_dio.dart';



class EmployeeUpdateApi {
  Future employeeUpdateApi(
      {required int companyID,
        required int branchID,
        required int employeeID,
        required String iqama,
        required String employeeName,
      }) async {
    String subUrl = "/api/company/$companyID/branch/$branchID/employee/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData = json.encode({
      "company": companyID,
      "branch": branchID,
      "user": employeeName,
      "employee_iqama": iqama,
    });

    final response = await Api().dio.put(
      uri,
      data: bodyData,
      queryParameters: {
        "employee_id":employeeID
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