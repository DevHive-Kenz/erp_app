import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/style_manager.dart';
import '../../constants/app_routes.dart';
import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';

class SquareTileWidget extends HookWidget {
  const SquareTileWidget(
      {Key? key,
      required this.index,
      required this.onTap,
      required this.name,
      this.icon = Icons.apartment})
      : super(key: key);
  final int index;
  final String name;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          // color: Colors.blueGrey,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(160.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorManager.primaryLight,
                ColorManager.onPrimaryLight,
              ],
            ),
          ),
          child: Stack(
            children: [

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon,
                        color: ColorManager.white, size: FontSize.s30),
                    kSizedBox10,
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        name,
                        style: getSemiBoldStyle(color: Colors.white)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
