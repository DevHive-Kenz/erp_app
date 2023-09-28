import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/core/notifier/total_invoice/total_invoice_notifier.dart';
import 'package:kenz_app/provider/search_notifier.dart';
import 'package:kenz_app/screens/widget/appbar_main_widget.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/screens/widget/text_field_widget.dart';
import 'package:provider/provider.dart';
import '../../../constants/font_manager.dart';
import '../../../models/total_invoice_model/total_invoice_result_model.dart';

class TotalInvoice extends HookWidget {
  const TotalInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    final fromController = useTextEditingController();
    final toController = useTextEditingController();

    Future _selectDate(BuildContext context,dateTransfer) async {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: ColorManager.primaryLight,
              colorScheme: ColorScheme.light(primary: ColorManager.primaryLight),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );
      if (picked != null) {
        dateTransfer.text = formatter.format(picked);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MainAppBarWidget(isFirstPage: false,title: "Total Invoice",),
            kSizedBox20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Invoice',style: getBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),
                  InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            title: Text(
                             "Please Select Date Range",
                              style: getSemiBoldStyle(
                                  color: ColorManager.black, fontSize: FontSize.s16),
                            ),
                            content: Row(
                              children: [
                                Expanded(child: TextFormFieldCustom(
                                  controller: fromController,hintName: "From Date",isReadOnly: true,onTap: ()=>_selectDate(context, fromController),)),
                                kSizedW15,
                                Expanded(child: TextFormFieldCustom(controller: toController,hintName: "To Date",isReadOnly: true,onTap: ()=>_selectDate(context, toController))),
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text(
                                    "Cancel",
                                    style: getSemiBoldStyle(
                                        color: ColorManager.primaryLight, fontSize: FontSize.s16),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    context.read<SearchProvider>().setStartAndEndDate(endDate: DateTime.parse(toController.text),startDate: DateTime.parse(fromController.text));
                                  },
                                  child: Text(
                                   "Search",
                                    style: getSemiBoldStyle(
                                        color: ColorManager.primaryLight, fontSize: FontSize.s16),
                                  )),
                            ],
                          ),
                        );
                      },
                      child: Icon(Icons.filter_list_rounded,color: ColorManager.primaryLight,))
                ],
              ),
            ),
            kSizedBox20,
            Consumer<SearchProvider>(
              builder: (context, snapshot,_) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: ListView.separated(
                      itemCount: snapshot.getInvoiceList.reversed.length,
                     shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>  kSizedBox8,
                      itemBuilder: (BuildContext context, int index) {
                        TotalInvoiceResultModel? data = snapshot.getInvoiceList.reversed.toList()[index];
                        return InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: ColorManager.filledColor2,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(data.,style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),) ,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${data?.id} ",style: getBoldStyle(color: ColorManager.black,),) ,
                                    Text(dateFormatter.format(data?.date ?? DateTime.now()),style: getBoldStyle(color: ColorManager.black,),) ,
                                  ],
                                ),
                                Text("${data?.amount} ",style: getBoldStyle(color: ColorManager.black,),),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: CustomButton(onTap: (){}, title: "Print",width: 90.w,height: 50.h,))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            ),
            kSizedBox20,

          ],
        ),
      ),
    );
  }
}
