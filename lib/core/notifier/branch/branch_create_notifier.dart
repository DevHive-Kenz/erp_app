import 'package:flutter/material.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/color_manger.dart';
import '../../../constants/constants.dart';
import '../../../constants/string_manager.dart';
import '../../api/auth/login_api.dart';
import '../../api/branch/branch_create_api.dart';
import '../../api/company/comapny_create_api.dart';
import '../../service/shared_preferance_service.dart';
import 'branch_list_notifier.dart';


class BranchCreateNotifier extends ChangeNotifier {
  final BranchCreateApi _createBranchAPI = BranchCreateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  CacheService cashService = CacheService();

  Future<void> postBranch({
    required BuildContext context,
    required String name,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      final data   = await _createBranchAPI.branchCreateApi(companyID: companyID, name: name);
      if(data["status"] == 200 || data["status"] == 201){
        await context.read<BranchListNotifier>().fetchBranchList(context: context);
        showSnackBar(context: context, text: data["message"],color: ColorManager.green);

        // Navigator.pushReplacementNamed(context, mainRoute);
      }else{
        showSnackBar(context: context, text: data["message"]);
      }
      _isLoading = false;
      notifyListeners();
    } catch(error){
      _isLoading = false;
      notifyListeners();
    }
  }
}