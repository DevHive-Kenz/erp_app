import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import '../../constants/app_routes.dart';
import '../widget/appbar_main_widget.dart';
import '../widget/text_field_widget.dart';




class SalesAddScreen extends HookWidget {
  const SalesAddScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final customerController = useTextEditingController();
    final poDateController = useTextEditingController();
    final poNumberController = useTextEditingController();

    return  Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MainAppBarWidget(
                    isFirstPage: false,
                    title: "Add the product"
                ),
                kSizedBox10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Container(
                      padding:const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p12) ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Enter Product Details",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s16),),
                          kSizedBox15,
                          TextFormFieldCustom(
                            controller: customerController,
                            hintName: "Item Name *",
                          ),
                          kSizedBox15,
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: customerController,
                                  hintName: "Quantity",
                                ),
                              ),
                              kSizedW10,

                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: customerController,
                                  hintName: "Unit",
                                ),
                              ),
                            ],
                          ),
                          kSizedBox15,
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: customerController,
                                  hintName: "Rate (Price/Unit)",
                                ),
                              ),
                              kSizedW10,

                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: customerController,
                                  hintName: "Vat ",
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                  ),
                ),
                kSizedBox10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Container(
                    padding:const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p12) ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Totals & Taxes",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s16),),
                        kSizedBox15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal (Rate x Qty)",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Text("132 SAR",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                          ],
                        ),
                        kSizedBox15,
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldCustom(
                                controller: customerController,
                                hintName:"Discount (%)",
                              ),
                            ),
                            kSizedW10,
                            Expanded(
                              child: TextFormFieldCustom(
                                controller: customerController,
                                hintName: "Discount (Fixes)",
                              ),
                            ),
                          ],
                        ),
                        kSizedBox15,
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldCustom(
                                controller: customerController,
                                hintName:"Tax %",
                              ),
                            ),
                            kSizedW10,
                            Expanded(
                              child: TextFormFieldCustom(
                                controller: customerController,
                                hintName: "6 SAR",
                              ),
                            ),
                          ],
                        ),
                        kSizedBox15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Amount:",style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Text("138.60 SAR",style:  GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  shadows: [
                                    Shadow(
                                        color: ColorManager.black,
                                        offset: Offset(0, -5))
                                  ],
                                  fontSize: FontSize.s16,
                                  color: Colors.transparent,
                                  decorationColor: ColorManager.black,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dashed,
                                )
                            )),
                          ],
                        ),
                        kSizedBox20,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: CustomButton(onTap: (){
                                Navigator.pushNamed(context, salesItemAdding);
                              }, title: "Save & Exit",width: 100.w,height: 40.h,),
                            ),
                            Center(
                              child: CustomButton(onTap: (){
                                Navigator.pushNamed(context, salesItemAdding);
                              }, title: "Save & Add",width: 100.w,height: 40.h,),
                            ),
                          ],
                        )
                      ],
                    ),


                  ),
                )
              ],
            ),
          )

      ),
    );
  }
}
