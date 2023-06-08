import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';
import '../../constants/values_manger.dart';
import '../widget/appbar_main_widget.dart';
import '../widget/square_tile_widget.dart';

class CompanyScreen extends HookWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalNotifier = context.watch<GeneralNotifier>();
    double screenWidth = MediaQuery.of(context).size.width;
     generalNotifier.checkAxisCount(context: context);
    print(screenWidth);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainAppBarWidget(isFirstPage: true,title: "Company",),
            kSizedBox20,

              Expanded(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Companies",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),
                      kSizedBox20,
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: generalNotifier.getAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: List.generate(20, (index) {
                            return SquareTileWidget(index: index,onTap: (){
                              Navigator.pushNamed(context, branchRoute);
                            },);
                          })..add(kSizedBox2),
                        ),
                      )
                    ],
                  ),
            ),
              )
          ],
        ),
      ),
    );
  }
}


