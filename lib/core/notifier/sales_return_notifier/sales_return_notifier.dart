// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../models/sales_return_model/sales_return_model.dart';
import '../../api/sales_api/sales_return_api.dart';
import '../../service/shared_preferance_service.dart';



class SalesReturnNotifier extends ChangeNotifier {
  final SalesReturnApi _salesReturnApi = SalesReturnApi();

  bool _isLoading = false;
  int? _statusCode;
  SalesReturnModel? _salesReturnModelData;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  SalesReturnModel? get getSalesReturnModelData => _salesReturnModelData;


  Future<String?> salesReturn({
    required BuildContext context,
    required String invoiceNumber,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      // final generalNotifier = context.read<GeneralNotifier>();

      final listData = await _salesReturnApi.salesReturn(invoiceNumber: invoiceNumber);

      if(listData["status"] == 200){
        _isLoading = false;
        _salesReturnModelData = SalesReturnModel.fromJson(listData);
        notifyListeners();
        return "OK";
      }else{
        _isLoading = false;
        notifyListeners();
        showAwesomeDialogue(title: "Warning", content: "Please try againr", type: DialogType.WARNING,);
      }

      _isLoading = false;
      notifyListeners();
    } catch(error){
      showAwesomeDialogue(title: "Warning", content: "Please try again later", type: DialogType.WARNING,);
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}