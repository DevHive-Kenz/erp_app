import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import '../../constants/app_routes.dart';
import '../widget/appbar_main_widget.dart';
import '../widget/text_field_widget.dart';





class SalesScreen extends HookWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customerController = useTextEditingController();
    final poDateController = useTextEditingController();
    final poNumberController = useTextEditingController();

    return  Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          MainAppBarWidget(
              isFirstPage: false,
              title: "Sales"
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
                  Text("Invoice Details",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s16),),
                  kSizedBox8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
               Column(

                     children: [
                       Text("Invoice No",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s14),),
                       kSizedBox8,
                       Text("INV 0001",style: getSemiBoldStyle(color: ColorManager.black,),)
                     ],
                     ),
      Column(
        children: [
            Text("Invoice Date",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s14),),
            kSizedBox8,
            Text("14-09-2023",style: getSemiBoldStyle(color: ColorManager.black,),)
        ],
      )
    ],
    ),
                ],
              )

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
                    Text("Customer Selection",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s16),),
                    kSizedBox8,
                    TextFormFieldCustom(
                      controller: customerController,
                      hintName: "Customer *",
                    ),
                    kSizedBox8,
                    Row(
                      children: [
                        Expanded(
                          child: TextFormFieldCustom(
                            controller: customerController,
                            hintName: "PO Date",
                          ),
                        ),
                        kSizedW5,
                        Expanded(
                          child: TextFormFieldCustom(
                            controller: customerController,
                            hintName: "PO Number",
                          ),
                        ),
                      ],
                    ),
                    kSizedBox20,
                    Center(
                      child: CustomButton(onTap: (){
                        Navigator.pushNamed(context, salesItemAdding);
                      }, title: "Next",width: 100.w,height: 40.h,),
                    )
                  ],
                ),


            ),
          )
        ],
          )

      ),
    );
  }
}
