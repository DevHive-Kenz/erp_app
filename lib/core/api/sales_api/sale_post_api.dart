import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/api_const/api_const.dart';
import '../../interceptor/app_dio.dart';

class SalePostApi {
  Future salePostApi({
    required int user,
    required int soldTo,
    required String printType,
    required int invoiceID,
    required String paymentType,
    required double amount,
    required double totalTax,
    required String date,
    required int? quotationID,
    // required DateTime? supplyDate,
    required String? contractNumber,
    // required DateTime? dueDate,
    required String? invoicePeriod,
    required String? referenceNumber,
    required List items,
  }) async {
    const String subUrl = "/api/sales/";
    String uri = AppAPI.baseUrl + subUrl;
    final bodyData = json.encode({
      "user": user,
      "sold_to": soldTo,
      "print_type": printType,
      "invoice_id": invoiceID,
      "payment_type": paymentType,
      "amount": amount,
      "total_tax": totalTax,
      "date": date,
      "quotation_id": quotationID,
      // "supply_date": supplyDate,
      "contract_number": contractNumber,
      // "due_date": dueDate,
      "invoice_period": invoicePeriod,
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
