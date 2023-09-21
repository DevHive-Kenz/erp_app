// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kenz_app/core/notifier/profile_notifier/profile_notifier.dart';
import 'package:kenz_app/provider/current_sale_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../models/sales_return_model/sales_return_model.dart';
import '../../api/sales_api/sale_post_api.dart';
import '../../api/sales_api/sales_return_api.dart';
import '../../service/shared_preferance_service.dart';



class SalesPostNotifier extends ChangeNotifier {
  final SalePostApi _salesPostApi = SalePostApi();

  bool _isLoading = false;
  int? _statusCode;


  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;



  Future<String?> salesPost({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      // final generalNotifier = context.read<GeneralNotifier>();
       final currentNotifier = context.read<CurrentSaleNotifier>();
       final profileNotifier = context.read<ProfileNotifier>();
      currentNotifier.calculate();
      final listData = await _salesPostApi.salePostApi(
          user: profileNotifier.getProfile?.result?[0].userId ?? 0,
          soldTo:currentNotifier.getSelectedCustomer?.id ?? 0,
          printType: currentNotifier.getPrintType ?? "",
          invoiceID: currentNotifier.getInvoiceID ?? 0,
          paymentType: currentNotifier.getPaymentMethod ?? "",
          amount: double.parse((currentNotifier.getTotalAmount ?? 0.00).toStringAsFixed(2)),
          totalTax: double.parse((currentNotifier.getTotalVat ?? 0.00).toStringAsFixed(2)),
          date: (currentNotifier.getDate ?? DateTime.now()).toString(),
          quotationID: null,
          // supplyDate: null,
          contractNumber: null,
          // dueDate: null,
          invoicePeriod: null,
          referenceNumber: currentNotifier.getPoNumber ?? "",
          items: currentNotifier.getItemList);

      if(listData["status"] == 200 || listData["status"] == 201){
        _isLoading = false;
        notifyListeners();
        return "OK";
      }else{
        _isLoading = false;
        notifyListeners();
        showAwesomeDialogue(title: "Warning", content: "Please try again", type: DialogType.WARNING,);
      }
      _isLoading = false;
      notifyListeners();
    } catch(error){
      showAwesomeDialogue(title: "Warning", content: "Please try again later $error", type: DialogType.WARNING,);
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}