import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../constants/api_const/api_const.dart';
import '../../../interceptor/app_dio.dart';

class EmployeeCreateApi {
  Future employeeCreateApi(
      {required int companyID,
      required int branchID,
      required int user,
      required String iqama,
      required String employeeName,
      }) async {
    String subUrl = "/api/company/$companyID/branch/$branchID/employee/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData = json.encode({
      "company": companyID,
      "branch": branchID,
      "user":user,
      "employee_name": employeeName,
      "employee_iqama": iqama,
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
