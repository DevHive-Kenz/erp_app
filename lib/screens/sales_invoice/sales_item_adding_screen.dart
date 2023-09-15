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

class SalesItemAddingScreen extends HookWidget {
  const SalesItemAddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customerController = useTextEditingController();
    final poDateController = useTextEditingController();
    final receiveMoneyController = useTextEditingController();
    final isReceived = useState<bool>(false);

    return  Scaffold(
      appBar: PreferredSize(
        preferredSize:  Size(double.infinity, 150.h),
        child: SafeArea(
          child: Container(
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
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back_rounded),
                        ),
                        kSizedW10,
                        Flexible(
                          child: Text(
                            "Customer Name",
                            overflow: TextOverflow.ellipsis,
                            style: getBoldStyle(
                                color: ColorManager.primaryLight,
                                fontSize: FontSize.s20),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.save)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.print))
                    ],
                  )
                ],
              ),
            ),
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                // MainAppBarWidget(
                //     isFirstPage: false,
                //     title: "Customer Name"
                // ),
                kSizedBox10,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p12),
                    decoration: BoxDecoration(
                      gradient:  LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorManager.primaryLight,
                          ColorManager.onPrimaryLight
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),

                    child: Row(
                      children: [
                        Icon(Icons.arrow_drop_down_circle,color: ColorManager.white),
                        kSizedW5,
                        Text("Added Items",style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s14,),),
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
                      color: ColorManager.greyFill,

                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p6,vertical: AppPadding.p6),
                                      decoration: BoxDecoration(
                                          color: ColorManager.white,
                                          borderRadius: BorderRadius.circular(8.r)
                                      ),
                                      child: Text("#1",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s10,))

                                  ),
                                  kSizedW5,
                                  Text("Afia oil",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,))
                                ],
                              ),
                              Text("140.6 SAR",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,))

                            ],
                          ),
                          ProductCardRow(title: "item Subtotal",content: "1 Ctn x 132 = 132 SAR",),
                          kSizedBox2,
                          ProductCardRow(title: "Discount (%):",content: "1 Ctn x 132 = 132 SAR",),
                          kSizedBox2,
                          ProductCardRow(title: "Total VAT@5%: 5%",content: "6.6 SAR",)

                        ]),
                  ),
                ),
                kSizedBox10,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Disc: 0.0",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s10,),),
                          Text("Total Vat Amt: 6.6",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s10,),),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Qty: 1",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s10,),),
                          Text("Subtotal: 138.6",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s10,),),

                        ],
                      )
                    ],
                  ),
                ),
                kSizedBox10,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p12),
                    decoration: BoxDecoration(
                      gradient:  LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorManager.primaryLight,
                          ColorManager.onPrimaryLight
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add,color: ColorManager.white),
                        kSizedW5,
                        InkWell(
                            onTap: ()=> Navigator.pushNamed(context, salesAddScreen),
                            child: Text("Add Items",style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s14,),)),
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
                      color: ColorManager.greyFill,

                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Summary",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s16,)),
                          kSizedBox10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Amount",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                              Text("138 SAR",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                            ],
                          ),
                          kSizedBox10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: AppPadding.p8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width:5,
                                      height:5,
                                      child: Checkbox(
                                        value: isReceived.value,
                                        onChanged: (value){
                                          isReceived.value = value ?? false;
                                        },
                                        checkColor: ColorManager.white,
                                        side: BorderSide(
                                          color: ColorManager.primaryLight,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    kSizedW15,
                                    Text("Received",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                                  ],
                                ),
                              ),
                            SizedBox(width: 100.w,child: TextFormFieldCustom(
                                controller: receiveMoneyController, hintName: "in SAR",)),
                            ],
                          ),
                          kSizedBox10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Balance Due",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                              Text("138 SAR",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                            ],
                          ),

                        ]),
                  ),
                ),
                kSizedBox10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Container(
                    padding:const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p12) ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: ColorManager.greyFill,

                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Payment Type 💵",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                        Text("Cash",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                      ],
                    ),
                  ),
                ),
                kSizedBox50
              ],
            )

          ],
        ),
      ),
    );
  }
}

class ProductCardRow extends StatelessWidget {
  const ProductCardRow({
    super.key,
    required this.content,
    required this.title,
  });
final String title;
final String content;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: getSemiBoldStyle(color: ColorManager.grey,)),
        Text(content,style: getSemiBoldStyle(color: ColorManager.grey,))
      ],
    );
  }
}
