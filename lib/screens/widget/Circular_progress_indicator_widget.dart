import 'package:flutter/material.dart';
import 'package:kenz_app/constants/color_manger.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: ColorManager.primaryLight,
        valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white),
      ),
    );
  }
}
