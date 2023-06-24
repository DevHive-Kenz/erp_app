import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/app_routes.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/core/notifier/company/company_List_notifier.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/widget/appbar_main_widget.dart';
import 'package:kenz_app/screens/widget/square_tile_widget.dart';
import 'package:provider/provider.dart';

import '../../../constants/values_manger.dart';
import '../../core/notifier/branch/branch_list_notifier.dart';
import '../widget/Circular_progress_indicator_widget.dart';
import 'branch_form_screen.dart';

class BranchScreen extends HookWidget {
  const BranchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalNotifier = context.watch<GeneralNotifier>();
    double screenWidth = MediaQuery.of(context).size.width;
    generalNotifier.checkAxisCount(context: context);
    final isEditingEnabled = useState<bool>(false);
    print(screenWidth);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainAppBarWidget(
              isFirstPage: false,
              title: generalNotifier.getCompanyName ?? "Branches",
            ),
            kSizedBox20,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Branches",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),
                        IconButton(
                          icon: Icon(!isEditingEnabled.value ? Icons.edit : Icons.edit_off, color: Colors.black, size: FontSize.s24),
                          onPressed: () {
                            isEditingEnabled.value = !isEditingEnabled.value;
                            // Add your editing functionality here
                          },
                        ),
                      ],
                    ),
                    kSizedBox20,
                    Consumer<BranchListNotifier>(
                        builder: (context, snapshot,_) {
                          return snapshot.getIsLoading ? const CircularProgressIndicatorWidget() :Expanded(
                            child: GridView.count(
                              crossAxisCount: generalNotifier.getAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: List.generate(snapshot.getBranchModel?.result?.length ?? 0, (index) {
                                final data = snapshot.getBranchModel?.result?[index];
                                return SquareTileWidget(
                                  icon: Icons.store_mall_directory_rounded,
                                  index: index,
                                  onTap: (){
                                    generalNotifier.selectedBranchID(branchID: data!.id!,name: data.name! ?? "" );
                                    Navigator.pushNamed(context, categoryRoute);
                                  },
                                  onEditTap: (){
                                    generalNotifier.selectedBranchID(branchID: data!.id!,name: data.name! ?? "" );
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BranchFormScreen(isEditing: true,)));
                                  },
                                  isEditingEnabled: isEditingEnabled,
                                  name: data?.name ?? "",);
                              })..add(kSizedBox2),
                            ),
                          );
                        }
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BranchFormScreen(isEditing: false,))),
          tooltip: 'Increment',
          // backgroundColor: ColorManager.red,
          child:  Icon(Icons.add,color: ColorManager.white,),
        )
    );
  }
}
