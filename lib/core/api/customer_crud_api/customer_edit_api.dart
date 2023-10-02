import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class CustomerEditCrudApi {
  Future customerEdit({
    required String customerID,
    required String name,
    required String nameA,
    required String address1,
    required String address1A,
    required String address2,
    required String address2A,
    required String crn,
    required String vat,
    required bool isCustomer,
    required bool isVendor,
    required bool isEmployee,
    required bool isRep,
    // required bool approved,
    required int userID,
    required int? route,
    required int? region,
    required int? rep,
    required int? group,
    required int? priceList,

  }) async {
     String subUrl = "/api/customers_edit/$customerID/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData = json.encode({
      "name": name,
      "name_a":nameA,
      "address1": address1,
      "address1_a": address1A,
      "address2": address2,
      "address2_a": address2A,
      "crn_number": crn,
      "vat_number": vat,
      "is_customer": isCustomer,
      "is_vendor": isVendor,
      "is_employee": isEmployee,
      "is_rep": isRep,
      // "approved": true,
      "user": userID,
      "route": route,
      "region": region,
      "rep": rep,
      "group": group,
      "price_list": priceList
    });
    final response = await Api().dio.patch(
        uri,
        data: bodyData
    );
    final statusCode = response.statusCode;
    final body = response.data;
    if (statusCode == 201 || statusCode == 200) {
      return body;
    }
  }
}