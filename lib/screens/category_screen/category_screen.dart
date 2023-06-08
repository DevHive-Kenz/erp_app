import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/widget/appbar_main_widget.dart';
import 'package:kenz_app/screens/widget/square_tile_widget.dart';
import 'package:provider/provider.dart';

import '../../../constants/values_manger.dart';
import '../../constants/app_routes.dart';
import '../category_company_screen/category_company_screen.dart';


class CategoryScreen extends HookWidget {
  const CategoryScreen({Key? key}) : super(key: key);

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
            MainAppBarWidget(isFirstPage: false,title: "Branch_name",),
            kSizedBox20,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Document Category",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),
                    kSizedBox20,
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: generalNotifier.getAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: List.generate(3, (index) {
                          return SquareTileWidget(index: index,onTap: (){
                            Navigator.pushNamed(context, categoryCompanyRoute);
                          },);
                        })..add(kSizedBox2),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


