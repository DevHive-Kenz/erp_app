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
import '../../api/customer_crud_api/customer_create_api.dart';
import '../../api/sales_api/sales_return_api.dart';
import '../../service/shared_preferance_service.dart';



class CustomerCreateNotifier extends ChangeNotifier {
  final CustomerCreateCrudApi _customerApi = CustomerCreateCrudApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;


  Future<String?> customerCreate({
    required BuildContext context,
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
    required int userID,
    required int? route,
    required int? region,
    required int? rep,
    required int? group,
    required int? priceList,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      // final generalNotifier = context.read<GeneralNotifier>();

      final listData = await _customerApi.customerCreate(
          name: name,
          nameA: nameA,
          address1: address1,
          address1A: address1A,
          address2: address2,
          address2A: address2A,
          crn: crn,
          vat: vat,
          isCustomer: isCustomer,
          isVendor: isVendor,
          isEmployee: isEmployee,
          isRep: isRep,
          userID: userID,
          route: route,
          group: group,
          priceList: priceList,
          region: region,
          rep: rep,
      );

      if(listData["status"] == 200){
        _isLoading = false;
        Navigator.pushNamed(context, mainRoute);

        showAwesomeDialogue(title: "Success", content:listData["message"] ?? "Customer is Successfully Send for Verification", type: DialogType.SUCCES,);
        notifyListeners();
        return "OK";
      }else{
        _isLoading = false;
        notifyListeners();
        showAwesomeDialogue(title: "Warning", content: listData["message"] ?? "Please Try Again", type: DialogType.WARNING,);
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