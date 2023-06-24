import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/color_manger.dart';
import '../../../constants/constants.dart';
import '../../../constants/string_manager.dart';
import '../../api/auth/login_api.dart';
import '../../api/company/comapny_create_api.dart';
import '../../service/shared_preferance_service.dart';
import 'company_List_notifier.dart';


class CompanyCreateNotifier extends ChangeNotifier {
  final CompanyCreateApi _createCompanyAPI = CompanyCreateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  CacheService cashService = CacheService();

  Future<String?> postCompany({
    required BuildContext context,
    required String name,
  }) async {
    try {
      String? user = await cashService.readCache(key: AppStrings.userID);
      _isLoading = true;
      notifyListeners();
      final data   = await _createCompanyAPI.companyCreateApi(name:name,user: user );
      if(data["status"] == 200 || data["status"] == 201){
        showSnackBar(context: context, text: data["message"],color: ColorManager.green);
            await context.read<CompaniesListNotifier>().fetchCompaniesList(context: context);
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
    return null;
  }
}