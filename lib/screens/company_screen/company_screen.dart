import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/company_screen/company_form_screen.dart';
import 'package:kenz_app/screens/widget/Circular_progress_indicator_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';
import '../../constants/values_manger.dart';
import '../../core/notifier/branch/branch_list_notifier.dart';
import '../../core/notifier/company/company_List_notifier.dart';
import '../widget/appbar_main_widget.dart';
import '../widget/square_tile_widget.dart';

class CompanyScreen extends HookWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalNotifier = context.watch<GeneralNotifier>();
    final isEditingEnabled = useState<bool>(false);
    final isLoading = useState<bool>(false);
    double screenWidth = MediaQuery.of(context).size.width;
    generalNotifier.checkAxisCount(context: context);
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
                    title: "Company",
                  ),
                  kSizedBox20,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Companies",
                                style: getSemiBoldStyle(
                                    color: ColorManager.primaryLight,
                                    fontSize: FontSize.s18),
                              ),
                              IconButton(
                                icon: Icon(
                                    !isEditingEnabled.value
                                        ? Icons.edit
                                        : Icons.edit_off,
                                    color: Colors.black,
                                    size: FontSize.s24),
                                onPressed: () {
                                  isEditingEnabled.value =
                                      !isEditingEnabled.value;
                                  // Add your editing functionality here
                                },
                              ),
                            ],
                          ),
                          kSizedBox20,
                          Consumer<CompaniesListNotifier>(
                              builder: (context, snapshot, _) {
                            return snapshot.getIsLoading
                                ? const CircularProgressIndicatorWidget()
                                : Expanded(
                                    child: GridView.count(
                                      crossAxisCount:
                                          generalNotifier.getAxisCount,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      children: List.generate(
                                          snapshot.getCompaniesData?.result
                                                  ?.length ??
                                              0, (index) {
                                        final data = snapshot
                                            .getCompaniesData?.result?[index];
                                        return SquareTileWidget(
                                          index: index,
                                          onTap: () async {
                                            isLoading.value =true;
                                            generalNotifier.selectedCompanyID(
                                                companyID: data!.id!,name: data.name ?? "");
                                            await context
                                                .read<BranchListNotifier>()
                                                .fetchBranchList(
                                                    context: context)
                                                .then((value) {
                                              if (value == "OK") {
                                                Navigator.pushNamed(
                                                    context, branchRoute);
                                              }
                                            });
                                            isLoading.value =false;

                                          },
                                          onEditTap: () {
                                            generalNotifier.selectedCompanyID(
                                                companyID: data!.id!,name: data.name ?? "");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CompanyFormScreen(
                                                          isEditing: true,
                                                        )));
                                          },
                                          isEditingEnabled: isEditingEnabled,
                                          name: data?.name ?? "",
                                        );
                                      })
                                        ..add(kSizedBox2),
                                    ),
                                  );
                          })
                        ],
                      ),
                    ),
                  )
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CompanyFormScreen(
                        isEditing: false,
                      ))),
          tooltip: 'Increment',
          // backgroundColor: ColorManager.red,
          child: Icon(
            Icons.add,
            color: ColorManager.white,
          ),
        ));
  }
}
