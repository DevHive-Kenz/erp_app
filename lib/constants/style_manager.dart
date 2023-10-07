import 'package:flutter/material.dart';
import 'font_manager.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle _getTextStyle(
    double fontSize,  FontWeight fontWeight, Color color,) {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight, )
  );
}

// regular style
TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontWeightManager.regular, color);
}

// light text style
 TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize,  FontWeightManager.light, color);
}
// bold text style

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontWeightManager.bold, color,);
}

// semi bold text style
TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize,  FontWeightManager.semiBold, color);
}

// medium text style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize,  FontWeightManager.medium, color);
}

///---------------------///


TextStyle _getTextInvoiceStyle(
    double fontSize,  FontWeight fontWeight, Color color,) {
  return GoogleFonts.abel(
      textStyle: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight, )
  );
}

// regular style
TextStyle getRegularInvoiceStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextInvoiceStyle(
      fontSize, FontWeightManager.regular, color);
}

// light text style
TextStyle getLightInvoiceStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextInvoiceStyle(
      fontSize,  FontWeightManager.light, color);
}
// bold text style

TextStyle getBoldInvoiceStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextInvoiceStyle(
    fontSize, FontWeightManager.bold, color,);
}

// semi bold text style
TextStyle getSemiBoldInvoiceStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextInvoiceStyle(
      fontSize,  FontWeightManager.semiBold, color);
}

// medium text style

TextStyle getMediumInvoiceStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextInvoiceStyle(
      fontSize,  FontWeightManager.medium, color);
}

///---------------------///

