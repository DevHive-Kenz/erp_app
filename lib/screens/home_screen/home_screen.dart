import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/core/notifier/series_fetch_notifier/series_fetch_notifier.dart';
import 'package:kenz_app/core/notifier/total_invoice/total_invoice_notifier.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/widget/appbar_main_widget.dart';
import 'package:kenz_app/screens/widget/square_tile_widget.dart';
import 'package:provider/provider.dart';
import '../../../constants/values_manger.dart';
import '../../constants/app_routes.dart';
import '../../core/notifier/sales_return/sales_return_notifier.dart';
import '../../provider/current_sale_notifier.dart';
import '../widget/Circular_progress_indicator_widget.dart';
import '../../core/notifier/product_notifier/product_notifier.dart';
import '../../core/notifier/customer_notifier/customer_notifier.dart';
import '../../core/notifier/profile_notifier/profile_notifier.dart';
import '../../core/notifier/master_data_notifier/master_data_notifier.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalNotifier = context.watch<GeneralNotifier>();
    double screenWidth = MediaQuery.of(context).size.width;
    final isEditingEnabled = useState<bool>(false);
    final currentNotifier = context.read<CurrentSaleNotifier>();

    final isLoading = useState<bool>(false);

    useEffect(() {
      Future.microtask(() => generalNotifier.checkAxisCount(context: context));

      return null;
    },[]);

    Future<void> callApiRefresh() async {
      await Future.wait([
        context.read<GeneralNotifier>().checkAxisCount(context: context),
        context.read<GeneralNotifier>().getUserNameFun(),
        context.read<ProductNotifier>().product(context: context),
        context.read<ProfileNotifier>().profile(context: context),
        context.read<CustomerNotifier>().customer(context: context),
        context.read<MasterDataCustomerNotifier>().masterData(context: context),

      ]);
    }

    print(screenWidth);
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainAppBarWidget(
                    isFirstPage: true,
                    title: ""

                  ),
                  kSizedBox20,
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Home",
                            style: getSemiBoldStyle(
                                color: ColorManager.primaryLight,
                                fontSize: FontSize.s18),
                          ),
                          kSizedBox20,
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: (){
                                return callApiRefresh();
                              },
                              child: GridView.count(
                                crossAxisCount: generalNotifier.getAxisCount,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: List.generate(5, (index) {
                                  String categoryType = index ==0 ? "Sales":index == 1 ?  "Total Invoice":index == 2 ? "Sales Return" :index == 3 ? "Total sales \n return":index == 4 ? "Create\nCustomer":"Add";
                                  return SquareTileWidget(
                                    icon: index ==0 ? Icons.point_of_sale_rounded :index == 1 ? Icons.receipt_long_rounded:index == 2 ? Icons.assignment_return_rounded :index == 3 ? Icons.featured_play_list_rounded:index == 4 ? Icons.person :Icons.add,
                                    index: index,
                                    onTap: () async {
                                      print(index);
                                      if(index==0){
                                       generalNotifier.setTypeOfTransaction= Transaction.sales;
                                        isLoading.value = true;
                                        await context.read<SeriesFetchNotifier>().seriesFetch(context: context, type: "INVOICE");
                                        isLoading.value = false;
                                          Navigator.pushNamed(context, sales);
                                      }else if (index == 1){
                                        generalNotifier.setTypeOfTransaction= Transaction.totalSales;
                                        isLoading.value = true;
                                        await context.read<TotalInvoiceNotifier>().totalInvoiceFetch(context: context).then((value){
                                          if(value == "OK"){
                                            Navigator.pushNamed(context, totalInvoice);
                                          }
                                        });
                                        isLoading.value = false;
                                      }else if (index == 2){
                                        currentNotifier.clearAll();
                                        generalNotifier.setTypeOfTransaction= Transaction.salesReturn;
                                        isLoading.value = true;
                                        await context.read<SeriesFetchNotifier>().seriesFetch(context: context, type: "INVOICE_RETURN");
                                        isLoading.value = false;
                                        Navigator.pushNamed(context, salesReturnScreen);
                                      }else if(index == 3){
                                        generalNotifier.setTypeOfTransaction= Transaction.totalSalesReturn;
                                        isLoading.value = true;
                                        await context.read<SalesReturnNotifier>().salesReturnList(context: context).then((value){
                                          if(value == "OK"){
                                            Navigator.pushNamed(context, totalSalesReturnInvoice);
                                          }
                                        });
                                        isLoading.value = false;

                                      }else if(index == 4){
                                        Navigator.pushNamed(context, customerCreateScreen);
                                      }
                                    },
                                    name: categoryType,
                                  );
                                })
                                  ..add(kSizedBox2),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: ColorManager.filledColor,
                              borderRadius: BorderRadius.circular(12)

                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text("Contact Support Team",style: getBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s14),),
                                  Icon(Icons.support_agent_rounded,color: ColorManager.primaryLight,size: FontSize.s24,)
                                ],
                              ),
                            ),
                          ),
                          kSizedBox10
                        ],
                      ),
                    ),
                  ),
                ],
              ),

               Consumer<GeneralNotifier>(
                builder: (context, snapshot,_) {
                  return snapshot.getIsLoading || isLoading.value ?  Positioned.fill(
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
