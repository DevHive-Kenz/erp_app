import 'package:flutter/material.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/constants.dart';
import '../../../constants/string_manager.dart';
import '../../api/auth/login_api.dart';
import '../../service/shared_preferance_service.dart';


class AuthNotifier extends ChangeNotifier {
  final LogInAPI _loginAPI = LogInAPI();

  bool _isLoading = false;
  int? _statusCode;
  String? _firebaseToken;
  String? _userName;

  String? get getUsername => _userName;
  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  
  CacheService cashService = CacheService();


  void setFirebaseToken(String token){
    _firebaseToken = token;
    notifyListeners();
  }

  Future<void> getLogin({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      final listData = await _loginAPI.login(password: password,userName: username, deviceToken:_firebaseToken ?? "");
      if(listData["status"] == 200){
        print(listData["result"]["token"]);
        print(listData["result"]["user"]);
        _userName = listData["result"]["user"];
        notifyListeners();
        // cashService.writeCache(key: AppStrings.token, value: listData["result"]["token"]);
        // cashService.writeCache(key: AppStrings.username, value: listData["result"]["user"]);
        // cashService.writeCache(key: AppStrings.userID, value: listData["result"]["user_id"].toString());
        // cashService.writeCache(key: AppStrings.role, value: "ADMIN");
        // cashService.writeCache(key: AppStrings.subscription, value: listData["result"]["subscripition_expiry"]);
        // cashService.writeCache(key: AppStrings.subscriptionStatus, value: listData["result"]["subscription_status"].toString());
        Navigator.pushReplacementNamed(context, mainRoute);
      }else{
        showSnackBar(context: context, text: listData["message"]);
      }
      _isLoading = false;
      notifyListeners();
    } catch(error){
      print("eroor $error");
      _isLoading = false;
      notifyListeners();
}
}
}