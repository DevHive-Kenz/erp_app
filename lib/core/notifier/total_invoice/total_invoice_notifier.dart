// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kenz_app/core/api/series_fetch_api/series_fetch_api.dart';
import 'package:kenz_app/core/api/total_invoice_api/total_invoice_api.dart';
import 'package:kenz_app/models/total_invoice_model/total_invoice_model.dart';
import 'package:kenz_app/provider/search_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../models/sales_return_model/sales_return_model.dart';
import '../../../provider/current_sale_notifier.dart';
import '../../api/sales_api/sales_return_api.dart';
import '../../service/shared_preferance_service.dart';



class TotalInvoiceNotifier extends ChangeNotifier {
  final TotalInvoiceApi _totalInvoiceApi = TotalInvoiceApi();

  bool _isLoading = false;
  int? _statusCode;
  TotalInvoiceModel? _totalInvoiceModel;


  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  TotalInvoiceModel? get getTotalInvoiceFetch => _totalInvoiceModel;



  Future<String?> totalInvoiceFetch({
    required BuildContext context,
  }) async {
    try {
      final searchNotifier = context.read<SearchProvider>();
      _isLoading = true;
      notifyListeners();
      searchNotifier.cleanSearchString();
      final listData = await _totalInvoiceApi.totalInvoiceApi();

      if(listData["status"] == 200){
      _totalInvoiceModel = TotalInvoiceModel.fromJson(listData);
      searchNotifier.initializeTotalList(_totalInvoiceModel?.result ?? []);
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
      print("${error}rrp ");
      showAwesomeDialogue(title: "Warning", content: "Please try again later", type: DialogType.WARNING,);
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}