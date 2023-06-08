import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class LogOutAPI {
  Future logOut() async {
    const String subUrl = "/users/logout";
    const String uri = AppAPI.baseUrl + subUrl;
    final response = await Api().dio.delete(
      uri,
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