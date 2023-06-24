import 'package:flutter/material.dart';
import 'package:kenz_app/constants/string_manager.dart';

import '../core/service/shared_preferance_service.dart';

enum CategoryType { EMPLOYEE, COMPANY, VEHICLE }

class GeneralNotifier extends ChangeNotifier {


  int _axisCount = 2;
  int? _selectedCompanyID;
  int? _selectedBranchID;
  int? _selectedDocumentID;
  int? _selectedListDocumentID;
  String? _userName;
  String? _branchName;
  String? _companyName;
  CategoryType? _CategoryType;

  int? get getSelectedCompanyID => _selectedCompanyID;
  int? get getSelectedBranchID => _selectedBranchID;
  int? get getSelectedDocumentID => _selectedDocumentID;
  int? get getSelectedListDocumentID => _selectedListDocumentID;
  int get getAxisCount => _axisCount;
  String? get getUserName => _userName;
  String? get getBranchName => _branchName;
  String? get getCompanyName => _companyName;
  CategoryType? get getCategoryType => _CategoryType;

  Future<void> checkAxisCount({required BuildContext context})async {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1200) {
      _axisCount = 6;
    } else if (screenWidth > 1000) {
      _axisCount = 4;
    }
    else if (screenWidth > 800) {
      _axisCount = 4;
    }  else if (screenWidth > 600) {
      _axisCount = 3;
    }else {
      _axisCount = 2;
    }
    notifyListeners();
  }

  Future<void> getUserNameFun() async {
    CacheService cashService = CacheService();
    _userName = await cashService.readCache(key: AppStrings.username);
notifyListeners();

  }

  void selectedCompanyID({required int companyID, required String name}){
    _selectedCompanyID = companyID;
    _companyName =name;
    notifyListeners();
  }

  void selectedBranchID({required int branchID, required String name}){
    _selectedBranchID = branchID;
    _branchName = name;
    notifyListeners();
  }

  void selectedCategoryID({ required CategoryType selectedType}){
    _CategoryType = selectedType;

    notifyListeners();
  }

  void selectedDocumentId({required int documentID}){
    _selectedDocumentID = documentID;
    notifyListeners();
  }

  void selectedListDocumentId({required int documentID}){
    _selectedListDocumentID = documentID;
    notifyListeners();
  }


}