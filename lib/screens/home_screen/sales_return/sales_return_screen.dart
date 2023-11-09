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
import 'package:kenz_app/screens/widget/Circular_progress_indicator_widget.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_routes.dart';
import '../../../core/notifier/sales_return/sales_return_by_id_notifier.dart';
import '../../../models/customer_model/customer_result_model.dart';
import '../../../provider/current_sale_notifier.dart';
import '../../../provider/search_notifier.dart';
import '../../widget/appbar_main_widget.dart';
import '../../widget/text_field_widget.dart';
import '../customer_create_screen/customer_create_screen.dart';





class SalesReturnScreen extends HookWidget {
  const SalesReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceController = useTextEditingController();
    ValueNotifier<String> invoiceDateController = useState<String>("");
    ValueNotifier<int?> selectedCustomerID = useState<int?>(null);
    ValueNotifier<DateTime> invoiceTimeStamp = useState<DateTime>(DateTime.now());
    final poNumberController = useTextEditingController();
    ValueNotifier<CustomerResultModel?>  selectedCustomer = useState<CustomerResultModel?>(null);
    final productsNotifier = context.read<CurrentSaleNotifier>();


    final searchCustomer = Provider.of<SearchProvider>(context);
    final customerNotifier = context.read<CustomerNotifier>();
    final seriesFetchNotifier = context.read<SeriesFetchNotifier>();
    final currentNotifier = context.read<CurrentSaleNotifier>();
    final profileNotifier = context.read<ProfileNotifier>();
    final DateTime nowDate = DateTime.now();
    final formKey = useMemoized(() => GlobalKey<FormState>());




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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MainAppBarWidget(
                      isFirstPage: false,
                      title: "Sales Return"
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
                          Text("Enter Invoice No.",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s16),),
                          kSizedBox20,
                          TextFormFieldCustom(
                            controller: invoiceController,
                            hintName: "Invoice Number *",
                            isValidate: true,
                            prefixText: profileNotifier.getProfile?.result?[0].companySalePrefix,

                          ),


                          kSizedBox20,
                          Consumer<SalesReturnByIdNotifier>(
                            builder: (context, snapshot,_) {
                              return snapshot.getIsLoading ? const CircularProgressIndicatorWidget() : Center(
                                child: CustomButton(onTap: (){
                                  if(formKey.currentState?.validate() ?? false) {
                                     snapshot.salesReturn(context: context, invoiceNumber: invoiceController.text).then((value) async {
                                        if(value == "OK"){
                                          productsNotifier.setSalesFirstData(
                                            user: profileNotifier.getProfile?.result?[0].userId ?? 0,
                                            date: snapshot.getSalesReturnData!.date!,
                                            printType: "thermal",
                                            soldTo: snapshot.getSalesReturnData!.soldToId,
                                            soldToName: snapshot.getSalesReturnData!.customerData!.name!,
                                            poNumber:snapshot.getSalesReturnData!.referenceNumber,
                                            poDate: snapshot.getSalesReturnData!.supplyDate,
                                            dataCustomer: snapshot.getSalesReturnData!.customerData!,
                                          );
                                          productsNotifier.setSalesId = snapshot.getSalesReturnData?.id;
                                          productsNotifier.setRecentProductList=snapshot.getSalesReturnData!.items ?? [];
                                          Navigator.pushNamed(context, salesItemAdding);
                                        }
                                     });
                                  }
                                }, title: "Next",width: 100.w,height: 50.h,),
                              );
                            }
                          )
                        ],
                      ),


                    ),
                  )
                ],
              ),
            ),
          )

      ),
    );
  }
}
