import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/branch_screen/branch_screen.dart';
import 'package:kenz_app/screens/widget/appbar_main_widget.dart';
import 'package:kenz_app/screens/widget/square_tile_widget.dart';
import 'package:provider/provider.dart';

import '../../../constants/values_manger.dart';
import '../../constants/app_routes.dart';
import '../../core/notifier/id_expiry_module/company_documents/company_document_list_notifier.dart';
import '../../core/notifier/id_expiry_module/employee_documents/employee_list_notifier.dart';
import '../../core/notifier/id_expiry_module/vehicle_documents/vehicle_list_notifier.dart';
import '../widget/Circular_progress_indicator_widget.dart';

class CategoryScreen extends HookWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalNotifier = context.watch<GeneralNotifier>();
    double screenWidth = MediaQuery.of(context).size.width;
    generalNotifier.checkAxisCount(context: context);
    final isEditingEnabled = useState<bool>(false);
    final isLoading = useState<bool>(false);

    print(screenWidth);
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainAppBarWidget(
                    isFirstPage: false,
                    title: generalNotifier.getBranchName ?? "Category",
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
                            "Document Category",
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
                              children: List.generate(3, (index) {
                                String categoryType = index ==1 ? "Company":index == 2 ? "Vehicle":"Employee";
                                return SquareTileWidget(
                                  isEditingEnabled: isEditingEnabled,
                                  icon: Icons.folder_copy_rounded,
                                  onEditTap: (){
                                    // generalNotifier.selectedCompanyID(companyID: data!.id! );
                                  },
                                  index: index,
                                  onTap: () async {
                                    if(categoryType == "Employee" || categoryType== "Company" || categoryType == "Vehicle"){
                                     isLoading.value = true;
                                      if(categoryType == "Employee"){
                                        generalNotifier.selectedCategoryID(selectedType: CategoryType.EMPLOYEE);
                                        await context.read<EmployeeListNotifier>().fetchEmployeeList(context: context,);
                                      }else if(categoryType== "Company"){
                                        generalNotifier.selectedCategoryID(selectedType: CategoryType.COMPANY);
                                        await context.read<CompanyDocumentListNotifier>().fetchCompanyDocumentList(context: context);
                                      }else if(categoryType == "Vehicle"){
                                        generalNotifier.selectedCategoryID(selectedType: CategoryType.VEHICLE);
                                        await context.read<VehicleListNotifier>().fetchVehicleList(context: context);
                                      }
                                     isLoading.value = false;
                                     Navigator.pushNamed(context, categoryCompanyRoute);
                                    }else{
                                      showSnackBar(context: context, text: "Please Select a Valid Option");

                                    }

                                  },
                                  name: categoryType,
                                );
                              })
                                ..add(kSizedBox2),
                            ),
                          )
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
