// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kenz_app/models/customer_model/customer_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../models/sales_return_model/sales_return_model.dart';
import '../../api/customer_api/customer_api.dart';
import '../../api/sales_api/sales_return/sales_return_api.dart';
import '../../service/shared_preferance_service.dart';



class CustomerNotifier extends ChangeNotifier {
  final CustomerApi _customerApi = CustomerApi();

  bool _isLoading = false;
  int? _statusCode;
  CustomerModel? _customerModelData;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  CustomerModel? get getCustomerModelData => _customerModelData;


  Future<String?> customer({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      // final generalNotifier = context.read<GeneralNotifier>();

      final listData = await _customerApi.customer();

      if(listData["status"] == 200){
        _isLoading = false;
        _customerModelData = CustomerModel.fromJson(listData);
        notifyListeners();
        return "OK";
      }else{
        _isLoading = false;
        notifyListeners();
        showAwesomeDialogue(title: "Warning", content: "Please try againq", type: DialogType.WARNING,);
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