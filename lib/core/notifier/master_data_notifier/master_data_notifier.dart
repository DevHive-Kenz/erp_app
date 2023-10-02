// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kenz_app/models/customer_model/customer_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../models/master_data_model/master_data_model.dart';
import '../../../models/sales_return_model/sales_return_model.dart';
import '../../api/customer_api/customer_api.dart';
import '../../api/master_data_api/master_data_api.dart';
import '../../api/sales_api/sales_return_api.dart';
import '../../service/shared_preferance_service.dart';



class MasterDataCustomerNotifier extends ChangeNotifier {
  final MasterDataApi _masterDataApi = MasterDataApi();

  bool _isLoading = false;
  int? _statusCode;
  MasterDataModel? _masterDataModel;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  MasterDataModel? get getMasterDataModel => _masterDataModel;


  Future<String?> masterData({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      // final generalNotifier = context.read<GeneralNotifier>();

      final listData = await _masterDataApi.masterDataApi();

      if(listData["status"] == 200){
        _isLoading = false;
        _masterDataModel = MasterDataModel.fromJson(listData);
        notifyListeners();
        return "OK";
      }else{
        _isLoading = false;
        notifyListeners();
        showAwesomeDialogue(title: "Warning", content: listData["message"], type: DialogType.WARNING,);
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