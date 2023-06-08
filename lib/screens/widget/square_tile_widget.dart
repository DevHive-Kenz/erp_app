import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_routes.dart';
import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';


class SquareTileWidget extends StatelessWidget {
  const   SquareTileWidget({
    Key? key,
    required this.index, required this.onTap
  }) : super(key: key);
  final int index;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // color: Colors.blueGrey,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorManager.primaryLight,
              ColorManager.onPrimaryLight

            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.apartment,color: ColorManager.white,size: FontSize.s36,),
              kSizedBox10,
              Text(
                'Company $index',
                style: TextStyle(color: Colors.white,fontSize: FontSize.s16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
