import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';

import '../../constants/app_routes.dart';
import '../widget/appbar_main_widget.dart';
import '../widget/text_field_widget.dart';

class StockTakeScreen extends HookWidget {
  const StockTakeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final barcodeController = useTextEditingController();
    final productCodeController = useTextEditingController();

    return Scaffold(

    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            MainAppBarWidget(
              isFirstPage: false,
              title: "Stock Take"
            ),

            kSizedBox20,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Product Details",style: getBoldStyle(color: ColorManager.primaryLight,fontSize: AppSize.s18),),
                  kSizedBox20,
                  TextFormFieldCustom(
                    controller: barcodeController,
                    icon: Icons.barcode_reader,
                    hintName: "Scan Barcode",
                  ),
                  kSizedBox20,
                  Row(
                    children: [
                      Expanded(flex:1,child: Text("Product Code",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s13),)),
                      Expanded(flex:2,child:  TextFormFieldCustom(controller: productCodeController,hintName: "Product Code",))
                    ],
                  ),
                  kSizedBox10,
                  Row(
                    children: [
                      Expanded(flex:1,child: Text("Name",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s13),)),
                      Expanded(flex:2,child:  TextFormFieldCustom(controller: productCodeController,hintName: "Name",))
                    ],
                  ),
                  kSizedBox10,
                  Row(
                    children: [
                      Expanded(flex:1,child: Text("Base Unit",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s13),)),
                      Expanded(flex:2,child:  TextFormFieldCustom(controller: productCodeController,hintName: "Base Unit",))
                    ],
                  ),
                  kSizedBox10,
                  Row(
                    children: [
                      Expanded(flex:1,child: Text("Scanned UOM",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s13),)),
                      Expanded(flex:2,child:  TextFormFieldCustom(controller: productCodeController,hintName: "Scanned UOM",))
                    ],
                  ),
                  kSizedBox10,
                  Row(
                    children: [
                      Expanded(flex:1,child: Text("QTY",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s13),)),
                      Expanded(flex:2,child:  TextFormFieldCustom(controller: productCodeController,hintName: "QTY",))
                    ],
                  ),
                  kSizedBox10,
                  Row(
                    children: [
                      Expanded(flex:1,child: Text("Total Base QTY",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s13),)),
                      Expanded(flex:2,child:  TextFormFieldCustom(controller: productCodeController,hintName: "Total Base QTY"))
                    ],
                  ),

                ],
              ),
            ),
            kSizedBox40,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(onTap: (){}, title: "Save & Add",height: 60,width: 140,),
                CustomButton(onTap: (){Navigator.pushNamed(context, stockViewScreen);}, title: "Continue",height: 60,width: 140,)
              ],
            )
          ],
        ),
      ),
    ),
    );
  }
}
