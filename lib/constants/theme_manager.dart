import 'package:flutter/material.dart';
import 'package:kenz_app/constants/style_manager.dart';

import 'color_manger.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {

   return ThemeData.light(useMaterial3: true).copyWith(
       textTheme: TextTheme(
         headline1: getSemiBoldStyle(
             color: ColorManager.black, fontSize: FontSize.s60),
         headline2: getRegularStyle(
             color: ColorManager.black, fontSize: FontSize.s36),
         headline3:
         getBoldStyle(color: ColorManager.black, fontSize: FontSize.s30),
         headline4: getBoldStyle(
             color: ColorManager.black, fontSize: FontSize.s24),
         headline5:getRegularStyle(
             color: ColorManager.black, fontSize: FontSize.s14),
         headline6: getBoldStyle(
             color: ColorManager.black, fontSize: FontSize.s20),
         subtitle1: getBoldStyle(
             color: ColorManager.black, fontSize: FontSize.s18),
         subtitle2: getRegularStyle(
             color: ColorManager.black, fontSize: FontSize.s16),
       ),
        colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: ColorManager.primaryLight,
            onPrimary:   ColorManager.onPrimaryLight,
            secondary: ColorManager.onSecondary,
            onSecondary: ColorManager.onSecondary,
            error: ColorManager.error,
            onError: ColorManager.onError,
            background: ColorManager.background,
            onBackground:ColorManager.onBackground,
            surface: ColorManager.surfaceLight,
            onSurface: ColorManager.white));


}
