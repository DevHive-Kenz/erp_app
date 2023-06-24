import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/screens/branch_screen/branch_screen.dart';
import 'package:kenz_app/screens/company_screen/company_form_screen.dart';

import '../../constants/app_routes.dart';
import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';

class SquareTileWidget extends HookWidget {
  const SquareTileWidget(
      {Key? key,
      required this.index,
      required this.onTap,
      required this.onEditTap,
      required this.name,
      required this.isEditingEnabled,
      this.icon = Icons.apartment})
      : super(key: key);
  final int index;
  final String name;
  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback onEditTap;
  final ValueNotifier isEditingEnabled;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          // color: Colors.blueGrey,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
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
              isEditingEnabled.value
                  ? Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: Icon(Icons.edit,
                              color: Colors.white, size: FontSize.s24),
                          onPressed: onEditTap),
                    )
                  : kSizedBox,
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon,
                        color: ColorManager.white, size: FontSize.s36),
                    kSizedBox10,
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.white, fontSize: FontSize.s16),
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
