import 'package:flutter/material.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/core/notifier/company/company_List_notifier.dart';
import 'package:provider/provider.dart';


import '../../../constants/constants.dart';

import '../../../provider/general_notifier.dart';
import '../../api/company/company_delete_api.dart';
import '../../service/shared_preferance_service.dart';


class CompanyDeleteNotifier extends ChangeNotifier {
  final CompanyDeleteApi _deleteCompanyApi = CompanyDeleteApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  CacheService cacheService = CacheService();

  Future<String?> deleteCompany({
    required BuildContext context,
  }) async {
    try {
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;

      _isLoading = true;
      notifyListeners();
      final data = await _deleteCompanyApi.companyDeleteApi(companyID: companyID!);
      _statusCode= data["status"];
      notifyListeners();
      if (_statusCode == 200 || _statusCode == 201 ) {
       await context.read<CompaniesListNotifier>().fetchCompaniesList(context: context);
       Navigator.pop(context);

       _isLoading = false;
        notifyListeners();
        return 'OK';
        // Handle successful deletion, e.g., navigate to a different screen
        showSnackBar(context: context, text: data["message"],color: ColorManager.green);

      } else {
        showSnackBar(context: context, text: data["message"]);
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}