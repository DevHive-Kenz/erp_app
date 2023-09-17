import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/core/notifier/series_fetch_notifier/series_fetch_notifier.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/widget/appbar_main_widget.dart';
import 'package:kenz_app/screens/widget/square_tile_widget.dart';
import 'package:provider/provider.dart';
import '../../../constants/values_manger.dart';
import '../../constants/app_routes.dart';
import '../widget/Circular_progress_indicator_widget.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalNotifier = context.watch<GeneralNotifier>();
    double screenWidth = MediaQuery.of(context).size.width;
    final isEditingEnabled = useState<bool>(false);
    final isLoading = useState<bool>(false);

    useEffect(() {
      Future.microtask(() => generalNotifier.checkAxisCount(context: context));

      return null;
    },[]);

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
                            child: GridView.count(
                              crossAxisCount: generalNotifier.getAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: List.generate(2, (index) {
                                String categoryType = index ==0 ? "Sales":index == 1 ? "Sales Return":"Add";
                                return SquareTileWidget(
                                  icon: index ==0 ? Icons.point_of_sale_rounded :index == 1 ? Icons.assignment_return_rounded :Icons.add,
                                  index: index,
                                  onTap: () async {
                                    print(index);
                                    if(index==0){
isLoading.value = true;
                                      await context.read<SeriesFetchNotifier>().seriesFetch(context: context, type: "INVOICE");
isLoading.value = false;

                                      Navigator.pushNamed(context, sales);


                                    }else if (index == 1){


                                    }
                                  },
                                  name: categoryType,
                                );
                              })
                                ..add(kSizedBox2),
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
              isLoading.value ? Positioned.fill(
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
