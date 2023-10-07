import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../constants/api_const/api_const.dart';
import '../../../interceptor/app_dio.dart';


class SalesReturnPostApi {
  Future salesReturnPostApi({
    required int user,
    required int customer,
    required String printType,
    required int salesID,
    required String paymentType,
    required double amount,
    required double totalTax,
    required String date,
    required String saleReturnNumber,
    required int? quotationID,
    // required DateTime? supplyDate,
    required String? contractNumber,
    // required DateTime? dueDate,
    required String? invoicePeriod,
    required String? referenceNumber,
    required List items,
  }) async {
    const String subUrl = "/api/sales/return/";
    String uri = AppAPI.baseUrl + subUrl;

    final bodyData = json.encode({
      "sale_return": salesID,
      "type": "normal",
      "user": user,
      "sale_pos_return": null,
      "return_customer": customer,
      "return_number": saleReturnNumber,
      "payment_type": paymentType,
      "amount": amount,
      "total_tax": totalTax,
      "date": date,
      "reference_number": referenceNumber,
      "items": items
    });
    final response = await Api().dio.post(
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
