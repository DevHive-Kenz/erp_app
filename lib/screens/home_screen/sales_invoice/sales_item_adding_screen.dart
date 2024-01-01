import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/core/notifier/sales_return/sales_return_post_notifier.dart';
import 'package:kenz_app/provider/current_sale_notifier.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/home_screen/sales_invoice/sales_add_item_screen.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_routes.dart';
import '../../../core/notifier/sales_post_notifier/sales_post_notifier.dart';
import '../../../provider/sales_printing_notifier.dart';
import '../../widget/Circular_progress_indicator_widget.dart';
import '../../widget/appbar_main_widget.dart';
import '../../widget/text_field_widget.dart';

class SalesItemAddingScreen extends HookWidget {
  const SalesItemAddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentType = useState<String>("CASH");
    final isLoading = useState<bool>(false);

    final currentSaleNotifier = context.read<CurrentSaleNotifier>();
    final salesPostNotifier = context.read<SalesPostNotifier>();
    final salesReturnPostNotifier = context.read<SalesReturnPostNotifier>();
    final chequeNumberController = useTextEditingController();
    final chequeDateController = useTextEditingController();
    final paymentNarrationController = useTextEditingController();
    final transactionNumberController = useTextEditingController();
    final generalNotifier = context.watch<GeneralNotifier>();

    final isReceived = useState<bool>(false);
     useEffect(() {
       Future.microtask(() {
         if(currentSaleNotifier.getItemList.length < 1){
           Navigator.pushNamed(context, salesAddScreen);
         }
       },);


       return null;

     },[]);

     Future<void> checkoutFun() async {
       isLoading.value =true;

       if(generalNotifier.getTypeOfTransaction == Transaction.sales){
      await salesPostNotifier.salesPost(context: context);
    }else if(generalNotifier.getTypeOfTransaction == Transaction.salesReturn){
         await salesReturnPostNotifier.salesReturnPost(context: context);
       }
       isLoading.value =false;

     }
    return  Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Consumer<CurrentSaleNotifier>(
                builder: (context, snapshot,_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          MainAppBarWidget(
                              isFirstPage: false,
                              title: currentSaleNotifier.getSoldToName ?? ""
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
                                children: [
                                  Icon(Icons.arrow_drop_down_circle,color: ColorManager.white),
                                  kSizedW5,
                                  Text("Added Items",style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s14,),),
                                ],
                              ),
                            ),
                          ),
                          kSizedBox10,
                          SizedBox(
                            height: MediaQuery.of(context).size.height/2.5,
                            child: ListView.separated(
                              itemCount: snapshot.getItemList.length,
                              itemBuilder: (context, index) {
                                Map<String,dynamic> data = snapshot.getItemList[index];
                                return InkWell(
                                  onDoubleTap: (){
                                    if(generalNotifier.getTypeOfTransaction != Transaction.salesReturn) {
                                      snapshot.deleteAnItem(index: index);
                                    }
                                  },
                                  onLongPress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => SalesAddScreen(editIndex: index,))),
                                  child: Padding(
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
                                                        child: Text("#${index +1}",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s10,))

                                                    ),
                                                    kSizedW5,
                                                    Text(data["item"],style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,))
                                                  ],
                                                ),
                                                Text("${data["total_amount"].toStringAsFixed(2)} SAR",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,))

                                              ],
                                            ),
                                            // ProductCardRow(title: "item Subtotal",content: "${data["quantity"]} ${data["unit"]} x ${data["price"]} = ${data["subTotal"]} SAR",),
                                            ProductCardRow(title: "QTY",content: " ${data["quantity"]} ${data["unit"]}",),
                                            kSizedBox2,
                                            ProductCardRow(title: "item Subtotal",content: " ${data["subTotal"]} SAR",),
                                            kSizedBox2,
                                            ProductCardRow(title: "Discount:",content: data["discount_amount"].toStringAsFixed(2),),
                                            kSizedBox2,
                                            ProductCardRow(title: "Total VAT@${data["tax"]}%:",content: "${data["tax_amount"].toStringAsFixed(2)} SAR",)

                                          ]),
                                    ),
                                  ),
                                );
                              }, separatorBuilder: (BuildContext context, int index) {
                               return kDivider;
                            },
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
                                    Text("Total Disc: ${snapshot.getTotalDisc?.toStringAsFixed(2)}",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s12,),),
                                    Text("Total Vat Amt: ${snapshot.getTotalVat?.toStringAsFixed(2)}",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s12,),),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Qty: ${snapshot.getTotalQty?.toStringAsFixed(2)}",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s12,),),
                                    Text("Subtotal: ${snapshot.getTotalSub?.toStringAsFixed(2)}",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s12,),),

                                  ],
                                )
                              ],
                            ),
                          ),
                          kSizedBox10,
                          generalNotifier.getTypeOfTransaction != Transaction.salesReturn ?   Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: InkWell(
                              onTap: ()=> Navigator.pushNamed(context, salesAddScreen) ,
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
                                    Text("Add Items",style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s14,),),
                                  ],
                                ),
                              ),
                            ),
                          ): kSizedBox,
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
                                        Text("${snapshot.getTotalAmount?.toStringAsFixed(2)} SAR",style: getSemiBoldStyle(color: ColorManager.green,fontSize: FontSize.s16,)),
                                      ],
                                    ),
                                    // kSizedBox10,
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(left: AppPadding.p8),
                                    //       child: Row(
                                    //         children: [
                                    //           SizedBox(
                                    //             width:5,
                                    //             height:5,
                                    //             child: Checkbox(
                                    //               value: isReceived.value,
                                    //               onChanged: (value){
                                    //                 isReceived.value = value ?? false;
                                    //               },
                                    //               checkColor: ColorManager.white,
                                    //               side: BorderSide(
                                    //                 color: ColorManager.primaryLight,
                                    //                 width: 2,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           kSizedW15,
                                    //           Text("Received",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   SizedBox(width: 100.w,child: TextFormFieldCustom(
                                    //       controller: receiveMoneyController, hintName: "in SAR",)),
                                    //   ],
                                    // ),
                                    // kSizedBox10,
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text("Balance Due",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                                    //     Text("138 SAR",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                                    //   ],
                                    // ),

                                  ]),
                            ),
                          ),
                          kSizedBox10,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: InkWell(
                              onTap: (){
                                showModalBottomSheet(
                                    backgroundColor:
                                    Colors.transparent,
                                    context: context,
                                    elevation: 500,
                                    isScrollControlled: true,
                                    shape:
                                    const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    builder:
                                        (BuildContext context) {
                                      return SingleChildScrollView(
                                        child: LayoutBuilder(
                                            builder: (BuildContextcontext, BoxConstraints constraints) {
                                              bool isSmallScreen = MediaQuery.of(context).size.width < 800;
                                              double widthFactor = isSmallScreen ? 1.0 : 0.7;
                                              return FractionallySizedBox(
                                                widthFactor: widthFactor,
                                                child: StatefulBuilder(
                                                    builder: (BuildContextcontext, setModalState) {
                                                      List paymentMethods = ["CASH","CHEQUE","CREDIT","EFT"];
                                                      return Padding(
                                                        padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(context).viewInsets.bottom,
                                                        ),
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: new BorderRadius.only(topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0),
                                                              )),
                                                          height: 350.h,
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: AppPadding.p8),
                                                          child:  Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              kSizedBox15,
                                                              Text(
                                                                "Select Payment Method",
                                                                style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                                              ),
                                                              kSizedBox20,
                                                              Expanded(
                                                                child: ListView.separated(
                                                                    separatorBuilder: (context, index) {
                                                                      return const Divider();
                                                                    },
                                                                    itemCount: paymentMethods.length,
                                                                    itemBuilder: (context, index) {
                                                                      return GestureDetector(
                                                                        onTap: () {
                                                                          snapshot.setPaymentMethod = paymentMethods[index];
                                                                          paymentType.value = paymentMethods[index];
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: Container(
                                                                          padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p8),
                                                                          child:  Text(
                                                                            paymentMethods[index],
                                                                            style: getRegularStyle(color: ColorManager.black, fontSize: FontSize.s14),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                              ),
                                                            ],
                                                          ),),
                                                      );
                                                    }),
                                              );
                                            }),
                                      );
                                    });
                              },
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
                                    Text(paymentType.value,style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14,)),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          kSizedBox10,
                          paymentType.value == "EFT" || paymentType.value == "CHEQUE"  ?    Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            child: Container(
                              padding:const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p12) ,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: ColorManager.greyFill,
                              ),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  paymentType.value == "EFT" ? Column(
                                    children: [
                                      TextFormFieldCustom(controller: transactionNumberController,hintName: "Enter Transaction Number *",isValidate: true,),
                                      kSizedBox10,
                                      TextFormFieldCustom(controller: paymentNarrationController,hintName: "Enter Payment Narration",),
                                    ],
                                  ):paymentType.value == "CHEQUE" ?
                                  Column(
                                    children: [
                                      TextFormFieldCustom(controller: chequeNumberController,hintName: "Cheque Number *",isValidate: true,),
                                      kSizedBox10,
                                      TextFormFieldCustom(controller: chequeDateController,hintName: "Cheque Date *",isReadOnly: true,isValidate: true,onTap:(){
                                        selectDate(context: context,dateTransfer: chequeDateController);
                                      },),
                                      kSizedBox10,
                                      TextFormFieldCustom(controller: paymentNarrationController,hintName: "Enter Payment Narration",),
                                    ],
                                  ):kSizedBox
                                 ]
                              ),
                            ),
                          ):kSizedBox,
                          kSizedBox10,
                          InkWell(
                            onTap: (){
                              AwesomeDialog(
                                  dismissOnTouchOutside: true,
                                  context: context,
                                  dialogType: DialogType.question,
                                  animType: AnimType.BOTTOMSLIDE,

                                  title: "Confirmation",
                                  desc: "Are you sure you want to Checkout",
                                  descTextStyle: getSemiBoldStyle(color: ColorManager.primaryLight),
                                  // desc:'Please login again',
                                  btnCancelOnPress: () {},
                                  btnOkText: "yes",
                                  btnOkOnPress: () async {
                                    if(paymentType.value == "EFT"){
                                      if(transactionNumberController.text.isNotEmpty){
                                        checkoutFun();
                                      }else{
                                        showSnackBar(context: context, text: "Please Enter Transaction Number");
                                      }
                                    }else if(paymentType.value == "CHEQUE"){
                                      if(chequeNumberController.text.isNotEmpty && chequeDateController.text.isNotEmpty){
                                        checkoutFun();

                                      }else{
                                        showSnackBar(context: context, text: "Please Enter Cheque Number/Date");
                                      }
                                    }else{
                                      checkoutFun();
                                    }

                                  },
                                  btnOkColor: ColorManager.primaryLight)
                                  .show();
                            },
                            child: Padding(
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

                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.shopping_cart_checkout_rounded,color: ColorManager.white),
                                      kSizedW5,
                                      Text("Checkout",style: getBoldStyle(color: ColorManager.white,fontSize: FontSize.s14,),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          kSizedBox50
                        ],
                      )

                    ],
                  );
                }
              ),
            ),
            Consumer<SalesPostNotifier>(
              builder: (context, snapshot,_) {
                return  snapshot.getIsLoading ? Positioned.fill(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          color: const Color(0x66ffffff),
                          child: const CircularProgressIndicatorWidget(),
                        ))):kSizedBox;
              }
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
