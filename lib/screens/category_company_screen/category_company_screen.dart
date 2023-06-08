import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/widget/appbar_main_widget.dart';
import 'package:kenz_app/screens/widget/square_tile_widget.dart';
import 'package:provider/provider.dart';

import '../../../constants/values_manger.dart';
import '../widget/list_builder_custom_widget.dart';


class CategoryCompanyScreen extends HookWidget {
  const CategoryCompanyScreen({Key? key}) : super(key: key);

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
                    Text("Company Documents",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),
                    kSizedBox20,
                    Expanded(
                      child:ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.grey,
                            thickness: 1,
                            height: 1,
                          );
                        },
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return ListBuilderCustomWidget();
                        },
                      )
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



