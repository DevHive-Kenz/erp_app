import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/core/notifier/customer_notifier/customer_notifier.dart';
import 'package:kenz_app/core/notifier/profile_notifier/profile_notifier.dart';
import 'package:kenz_app/core/notifier/series_fetch_notifier/series_fetch_notifier.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import 'package:provider/provider.dart';
import '../../constants/app_routes.dart';
import '../../models/customer_model/customer_result_model.dart';
import '../../provider/current_sale_notifier.dart';
import '../../provider/search_notifier.dart';
import '../widget/appbar_main_widget.dart';
import '../widget/text_field_widget.dart';





class SalesScreen extends HookWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customerController = useTextEditingController();
    final poDateController = useTextEditingController();
    ValueNotifier<String> invoiceDateController = useState<String>("");
    ValueNotifier<int?> selectedCustomerID = useState<int?>(null);
    ValueNotifier<DateTime> invoiceTimeStamp = useState<DateTime>(DateTime.now());
    final poNumberController = useTextEditingController();
    ValueNotifier<CustomerResultModel?>  selectedCustomer = useState<CustomerResultModel?>(null);

    final searchCustomer = Provider.of<SearchProvider>(context);
    final customerNotifier = context.read<CustomerNotifier>();
    final seriesFetchNotifier = context.read<SeriesFetchNotifier>();
    final profileNotifier = context.read<ProfileNotifier>();
    final DateTime nowDate = DateTime.now();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    Future selectDate(
        {TextEditingController? dateTransfer,
        ValueNotifier? dateTransferText}) async {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: nowDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),

        // lastDate: DateTime(20 + nowDate.year),
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
       if( dateTransfer != null){
         dateTransfer.text = formatter.format(picked);
       }else{
         invoiceTimeStamp.value = picked;
         dateTransferText?.value = formatter.format(picked);
       }
      }
    }

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
    useEffect(() {
      Future.microtask(() {
            searchCustomer.initializeCustomerList(
                customerNotifier.getCustomerModelData?.result ?? []);
            invoiceDateController.value = dateFormatter.format(DateTime.now());
      },);


      return null;
    },[]);
    return  Scaffold(
      body: SafeArea(
          child: Form(
            key: formKey,
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
                    kSizedBox20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                 Column(

                       children: [
                         Text("Invoice No",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s14),),
                         kSizedBox8,
                         Text("${profileNotifier.getProfile?.result?[0].companySalePrefix} ${formatString(seriesFetchNotifier.getSeriesFetch ?? "0")}",style: getSemiBoldStyle(color: ColorManager.black,),)
                       ],
                       ),
      Column(
        children: [
              Text("Invoice Date",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s14),),
              kSizedBox8,
              InkWell(
                  onTap: () {
                selectDate(dateTransferText: invoiceDateController);
              },
              child: Text(invoiceDateController.value,style: getSemiBoldStyle(color: ColorManager.black,),))
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
                      kSizedBox20,
                      TextFormFieldCustom(
                        controller: customerController,
                        hintName: "Customer *",
                        isReadOnly: true,
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
                                                      height: 500.h,
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: AppPadding.p8),
                                                      child:  Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          kSizedBox15,
                                                          Text(
                                                            "Search Customer",
                                                            style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                                          ),
                                                          kSizedBox10,
                                                          CupertinoSearchTextField(
                                                            onChanged: (value) {
                                                              setModalState(() {
                                                                searchCustomer.changeSearchString(value);
                                                              });
                                                            },
                                                            autofocus: true,
                                                          ),
                                                          kSizedBox20,
                                                          Expanded(
                                                            child: ListView.separated(
                                                                separatorBuilder: (context, index) {
                                                                  return const Divider();
                                                                },
                                                                itemCount: searchCustomer.getCustomerList.length,
                                                                itemBuilder: (context, index) {
                                                                  CustomerResultModel data = searchCustomer.getCustomerList[index];
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      customerController.text = "${data.name.toString()}\n${data.nameArabic.toString()}";
                                                                      selectedCustomerID.value = data.id;
                                                                      selectedCustomer.value = data;
                                                                      searchCustomer.changeSearchString("");
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: Container(
                                                                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p8),
                                                                      child:  Text(
                                                                        "${data.name.toString()}\n${data.nameArabic.toString()}",
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
                      ),
                      kSizedBox8,
                      TextFormFieldCustom(
                        controller: poNumberController,
                        hintName: "PO Number",
                        isValidate: false,
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: TextFormFieldCustom(
                      //         controller: poDateController,
                      //         hintName: "PO Date",
                      //         isReadOnly: true,
                      //         isValidate: false,
                      //
                      //         onTap: () {
                      //
                      //               selectDate(dateTransfer:  poDateController);
                      //         },
                      //       ),
                      //     ),
                      //     kSizedW5,
                      //
                      //   ],
                      // ),
                      kSizedBox20,
                      Center(
                        child: CustomButton(onTap: (){
                          if(formKey.currentState?.validate() ?? false) {
                            context.read<CurrentSaleNotifier>().setSalesFirstData(
                              user: profileNotifier.getProfile?.result?[0].userId ?? 0,
                              date: invoiceTimeStamp.value,
                              invoiceId: int.parse(seriesFetchNotifier.getSeriesFetch ?? "0"),
                              displayInvoiceId: "${profileNotifier.getProfile?.result?[0].companySalePrefix} ${formatString(seriesFetchNotifier.getSeriesFetch ?? "0")}",
                              printType: "thermal",
                              soldTo: selectedCustomerID.value, soldToName: customerController.text.split(" ").first,
                              poNumber: poNumberController.text,
                              poDate: poDateController.text, dataCustomer: selectedCustomer.value!,

                            );

                            Navigator.pushNamed(context, salesItemAdding);
                          }
                        }, title: "Next",width: 100.w,height: 40.h,),
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
