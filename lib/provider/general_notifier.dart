import 'package:flutter/material.dart';

class GeneralNotifier extends ChangeNotifier {


  int _axisCount = 2;

  int get getAxisCount => _axisCount;

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


}