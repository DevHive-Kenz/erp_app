import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kenz_app/constants/font_manager.dart';

import '../../constants/color_manger.dart';


class RoundedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback? function;
  final bool isError;
  const RoundedButtonWidget({
    Key? key,this.title="Button Name",@required this.function,this.isError=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: function!,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<
            RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36.0),
          ),
        ),
        elevation: MaterialStateProperty.all(0.0),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
      child: Ink(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                isError ?  ColorManager.primaryLight : ColorManager.primaryLight ,
                isError ?  ColorManager.onPrimaryLight:  ColorManager.onPrimaryLight
              ]),
          borderRadius:
          const BorderRadius.all(Radius.circular(36.0)),
        ),
        child: Container(
          constraints:  BoxConstraints(

              minHeight: 60.0.h), // min sizes for Material buttons
          alignment: Alignment.center,
          child:  Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),),
          ),
        ),
      ),
    );
  }
}
