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
import '../../../core/notifier/profile_notifier/profile_notifier.dart';
import '../../../models/total_invoice_model/total_invoice_result_model.dart';
import '../../../provider/current_sale_notifier.dart';
import '../../../provider/sales_printing_notifier.dart';
import '../../widget/Circular_progress_indicator_widget.dart';

class TotalInvoice extends HookWidget {
  const TotalInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    final fromController = useTextEditingController();
    final toController = useTextEditingController();
    final productsNotifier = context.read<CurrentSaleNotifier>();
    final profileNotifier = context.read<ProfileNotifier>();
    ValueNotifier<bool> isLoading = useState<bool>(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());


    String formatString(String input) {
      // Check if the input string is shorter than 4 characters
      if (input.length < 4) {
        // Pad the input string with leading zeros to make it 4 characters long
        return input.padLeft(4, '0');
      } else {
        // If the input is 4 characters or longer, return it as is
        return input;
      }
    }
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
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MainAppBarWidget(isFirstPage: false,title: "Total Invoice",),
                kSizedBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),

                  child: Form(
                    key: formKey,
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
                                      Expanded(child: TextFormFieldCustom(isValidate:true,
                                        controller: fromController,hintName: "From Date",isReadOnly: true,onTap: ()=>_selectDate(context, fromController),)),
                                      kSizedW15,
                                      Expanded(child: TextFormFieldCustom(isValidate:true,controller: toController,hintName: "To Date",isReadOnly: true,onTap: ()=>_selectDate(context, toController))),
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
                                          if(fromController.text.isNotEmpty && toController.text.isNotEmpty){
                                            print("ddd");
                                            context.read<SearchProvider>().setStartAndEndDate(endDate: DateTime.parse(toController.text),startDate: DateTime.parse(fromController.text));

                                          }else{
                                            showSnackBar(context: context, text: "Please select both dates");
                                          }
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
                                    Text(data?.customerData?.name ?? "",style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),) ,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${profileNotifier.getProfile?.result?[0].companySalePrefix} ${formatString(data?.id.toString() ?? "0")}",style: getBoldStyle(color: ColorManager.black,),) ,
                                        Text(dateFormatter.format(data?.date ?? DateTime.now()),style: getBoldStyle(color: ColorManager.black,),) ,
                                      ],
                                    ),
                                    Text("${data?.amount} SAR",style: getBoldStyle(color: ColorManager.black,),),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: CustomButton(onTap: () async {
                                          productsNotifier.setSalesFirstData(
                                            user: profileNotifier.getProfile?.result?[0].userId ?? 0,
                                            date: data!.date!,
                                            invoiceId: data.customerData!.id!,
                                            displayInvoiceId: "${profileNotifier.getProfile?.result?[0].companySalePrefix} ${formatString(data.customerData!.id!.toString())}",
                                            printType: "thermal",
                                            soldTo: data.soldToId,
                                            soldToName: data.customerData!.name!,
                                            poNumber:data.referenceNumber,
                                            poDate: data.supplyDate,
                                            dataCustomer: data.customerData!,
                                          );
                                          productsNotifier.setRecentProductList=data.items ?? [];
                                          isLoading.value = true;
                                         await context.read<InvoicePrintingNotifier>().printBluetoothInvoice(context: context);
                                          isLoading.value = false;

                                        }, title: "Print",width: 80.w,height: 35.h,))
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
          isLoading.value ?  Positioned.fill(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      color: const Color(0x66ffffff),
                      child: const CircularProgressIndicatorWidget(),
                    ))):kSizedBox
          ],
        ),
      ),
    );
  }
}
