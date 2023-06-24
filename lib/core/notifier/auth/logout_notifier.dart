import 'package:flutter/material.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/constants.dart';
import '../../../constants/string_manager.dart';
import '../../api/auth/login_api.dart';
import '../../api/auth/logout_api.dart';
import '../../service/shared_preferance_service.dart';


class LogOutNotifier extends ChangeNotifier {
  final LogOutAPI _loginAPI = LogOutAPI();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  CacheService cashService = CacheService();

  Future<void> getLogOut({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      final listData = await _loginAPI.logout();
      if(listData["status"] == 200){
        cashService.deleteCache(key: AppStrings.token);
        Navigator.pushReplacementNamed(context, loginRoute);
      }else{
        showSnackBar(context: context, text: listData["message"]);
      }
      _isLoading = false;
      notifyListeners();
    } catch(error){
      _isLoading = false;
      notifyListeners();
    }
  }
}