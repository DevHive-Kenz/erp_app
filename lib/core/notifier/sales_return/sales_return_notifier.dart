// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/constants.dart';
import '../../../constants/string_manager.dart';
import '../../../models/sales_return_by_id/sales_return_by_id_model.dart';
import '../../../models/sales_return_by_id/sales_return_result_by_id_model.dart';
import '../../../models/sales_return_model/sales_return_model.dart';
import '../../../models/sales_return_model/sales_return_result_model.dart';
import '../../../provider/general_notifier.dart';
import '../../../provider/search_notifier.dart';
import '../../api/sales_api/sales_return/sales_return_api.dart';
import '../../api/sales_api/sales_return/sales_return_by_id_api.dart';




class SalesReturnNotifier extends ChangeNotifier {
  final SalesReturnApi _salesReturnApi = SalesReturnApi();

  bool _isLoading = false;
  int? _statusCode;
  SalesReturnModel? _salesReturnModelData;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  SalesReturnModel? get getSalesReturnModelData => _salesReturnModelData;



  Future<String?> salesReturnList({
    required BuildContext context,
  }) async {
    try {
      final searchNotifier = context.read<SearchProvider>();
      searchNotifier.cleanSearchString();


      _isLoading = true;
      notifyListeners();
      // final generalNotifier = context.read<GeneralNotifier>();

      final listData = await _salesReturnApi.salesReturn();

      if(listData["status"] == 200){
        print("1111");
        _salesReturnModelData = SalesReturnModel.fromJson(listData);
        searchNotifier.initializeTotalSaleReturnList(_salesReturnModelData?.result ?? []);

        // _salesReturnModelData?.result?.forEach((element) {
        //   if(element.invoiceId.toString() == invoiceNumber){
        //     print("333");
        //     _salesReturnData = element;
        //     print("334433");
        //     notifyListeners();
        //   }
        // });
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
      print(error);
      showAwesomeDialogue(title: "Warning", content: "Please try again later", type: DialogType.WARNING,);
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}