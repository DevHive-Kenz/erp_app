import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';
import '../../constants/style_manager.dart';
import '../../constants/values_manger.dart';


class MainAppBarWidget extends StatelessWidget {
  const MainAppBarWidget({
    Key? key,
    required this.isFirstPage,
    this.title
  }) : super(key: key);
  final bool isFirstPage;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(12.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      height: 90.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isFirstPage ?  Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                ),
                kSizedW10,
                Text(
                  "Howdy, Jibin !!",
                  style: getBoldStyle(
                      color: ColorManager.primaryLight,
                      fontSize: FontSize.s20),
                )
              ],
            ) : Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_rounded),
                ),
                kSizedW10,

                Text(
                  title ?? "",
                  style: getBoldStyle(
                      color: ColorManager.primaryLight,
                      fontSize: FontSize.s20),
                )
              ],
            ),
            isFirstPage ?   IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_rounded,
                  color: ColorManager.grey1,
                )) : kSizedBox
          ],
        ),
      ),
    );
  }
}
