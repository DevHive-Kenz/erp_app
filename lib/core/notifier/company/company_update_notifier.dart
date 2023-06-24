import 'package:flutter/material.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_manger.dart';
import '../../../constants/constants.dart';
import '../../../constants/string_manager.dart';
import '../../api/company/company_update_api.dart';
import '../../service/shared_preferance_service.dart';
import 'company_List_notifier.dart';


class CompanyUpdateNotifier extends ChangeNotifier {
  final CompanyUpdateApi _updateCompanyAPI = CompanyUpdateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get statusCode => _statusCode;
  CacheService cashService = CacheService();

  Future<String?> updateCompany({
    required BuildContext context,
    required String name,
  }) async {
    try {
      _isLoading = true;
      String user = await cashService.readCache(key: AppStrings.userID);
      print("rrrrrrrrrrrrrrrrr");

      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      notifyListeners();

      final data = await _updateCompanyAPI.companyUpdateApi(
        user: int.parse(user),
        name: name,
        companyID: companyID,
      );

      if (data["status"] == 200) {
        await context.read<CompaniesListNotifier>().fetchCompaniesList(context: context);
        Navigator.pop(context);
        // Handle successful deletion, e.g., navigate to a different screen
        showSnackBar(context: context, text: data["message"],color: ColorManager.green);
     return "OK";
      } else {
        showSnackBar(context: context, text: data["message"]);
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      // Handle any errors that occur during the API call
    }
    return null;
  }
}