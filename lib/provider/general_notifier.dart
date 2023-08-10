import 'package:flutter/material.dart';
import 'package:kenz_app/constants/string_manager.dart';

import '../core/service/shared_preferance_service.dart';



class GeneralNotifier extends ChangeNotifier {


  int _axisCount = 2;

  String? _userName;


  int get getAxisCount => _axisCount;
  String? get getUserName => _userName;


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
    _userName = await cashService.readCache(key: AppStrings.userName);
notifyListeners();

  }



}