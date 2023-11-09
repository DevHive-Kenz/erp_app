// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kenz_app/core/api/profile_api/profile_api.dart';
import 'package:kenz_app/models/customer_model/customer_model.dart';
import 'package:kenz_app/models/profile_model/profile_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../models/sales_return_model/sales_return_model.dart';
import '../../api/customer_api/customer_api.dart';
import '../../api/sales_api/sales_return/sales_return_by_id_api.dart';
import '../../service/shared_preferance_service.dart';



class ProfileNotifier extends ChangeNotifier {
  final ProfileApi _profileApi = ProfileApi();

  bool _isLoading = false;
  int? _statusCode;
  ProfileModel? _profileModelData;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  ProfileModel? get getProfile => _profileModelData;


  Future<String?> profile({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      // final generalNotifier = context.read<GeneralNotifier>();

      final listData = await _profileApi.profile();

      if(listData["status"] == 200){
        _isLoading = false;
        _profileModelData = ProfileModel.fromJson(listData);
        notifyListeners();
        return "OK";
      }else{
        _isLoading = false;
        notifyListeners();
        showAwesomeDialogue(title: "Warning", content: "Please try againe", type: DialogType.WARNING,);
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