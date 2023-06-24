import 'package:flutter/material.dart';
import 'package:kenz_app/constants/color_manger.dart';


import '../../../constants/constants.dart';

import '../../../models/company/company_list_model.dart';
import '../../api/company/company_delete_api.dart';
import '../../api/company/company_list_api.dart';
import '../../service/shared_preferance_service.dart';



class CompaniesListNotifier extends ChangeNotifier {

  final CompaniesList _companiesListAPI = CompaniesList();

  bool _isLoading = false;
  int? _statusCode;
  CompanyListModel? _companiesData;

  bool get getIsLoading => _isLoading;
  int? get statusCode => _statusCode;
  CompanyListModel? get getCompaniesData => _companiesData;

  Future<String?> fetchCompaniesList({required BuildContext context}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _companiesListAPI.companiesList();
      if (data["status"] == 200) {
        _isLoading = false;
        notifyListeners();
        _companiesData = CompanyListModel.fromJson(data);
        notifyListeners();
        return "OK";
        // Handle successful deletion, e.g., navigate to a different screen
        // showSnackBar(context: context, text: data["message"],color: ColorManager.green);

      } else {
        showSnackBar(context: context, text: data["message"]);
      }


      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print("error $error");
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}