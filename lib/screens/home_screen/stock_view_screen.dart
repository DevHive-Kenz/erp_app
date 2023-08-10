import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';

import '../widget/appbar_main_widget.dart';
import '../widget/list_builder_custom_widget.dart';


class StockViewScreen extends HookWidget {
  const StockViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                MainAppBarWidget(
                    isFirstPage: false,
                    title: "Stock Take"
                ),
                kSizedBox4,
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                      child: ListView.separated(
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return kSizedBox;
                        },
                        itemCount:20,
                        itemBuilder: (BuildContext context, int index) {
                          return ListBuilderCustomWidget(
                            index: index +1,
                            name: "eeee",
                            code: "eee",
                            barcode: "ppp",
                            baseUnit: "lkk",
                              scannedQty: "LKK",
                            scannedUnit: "jio",
                            qty: "ppo",
                            onTap: () {},

                          );
                        },
                      ),
                    )),
                kSizedBox100,
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).viewPadding.bottom ,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,

                color: ColorManager.white,
                padding: const EdgeInsets.only(bottom: AppPadding.p16),
                child: Center(child: CustomButton(onTap: (){},title: "Post",),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
