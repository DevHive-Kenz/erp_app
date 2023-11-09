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
import '../../../provider/sales_printing_notifier.dart';
import '../../api/sales_api/sale_post_api.dart';
import '../../api/sales_api/sales_return/sales_return_by_id_api.dart';
import '../../service/shared_preferance_service.dart';
import '../series_fetch_notifier/series_fetch_notifier.dart';



class SalesPostNotifier extends ChangeNotifier {
  final SalePostApi _salesPostApi = SalePostApi();

  bool _isLoading = false;
  int? _statusCode;


  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

Future<void> successFunc(BuildContext context) async {
  Navigator.pushReplacementNamed(context, invoicePrintingScreen);
}

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
          soldTo:currentNotifier.getSelectedCustomer?.customerID ?? 0,
          printType: currentNotifier.getPrintType ?? "",
          invoiceID: currentNotifier.getSeriesID ?? 0,
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
        _statusCode = listData["status"];
        successFunc(context);
        _isLoading = false;
        notifyListeners();
        return "OK";
      }else if(listData["status"] == 400  && listData["result"] == "Invoice Number already exists"){
        await context.read<SeriesFetchNotifier>().seriesFetch(context: context, type: "INVOICE").then((value) {
          if(value == "OK"){
            salesPost(context:context);
          }else{
            showAwesomeDialogue(title: "Warning", content: "Couldn't Fetch Invoice Number, Please try again", type: DialogType.WARNING,);
          }
        });

      }else{
        _isLoading = false;
        notifyListeners();
        showAwesomeDialogue(title: "Warning", content: listData["message"], type: DialogType.WARNING,);
      }
    } catch(error){
      showAwesomeDialogue(title: "Warning", content: "Please try again later", type: DialogType.WARNING,);
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}