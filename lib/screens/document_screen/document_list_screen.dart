import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/document_screen/document_List_form_screen.dart';
import 'package:kenz_app/screens/widget/Circular_progress_indicator_widget.dart';
import 'package:kenz_app/screens/widget/appbar_main_widget.dart';
import 'package:kenz_app/screens/widget/square_tile_widget.dart';
import 'package:provider/provider.dart';

import '../../../constants/values_manger.dart';
import '../../core/notifier/id_expiry_module/company_documents/company_document_list_notifier.dart';
import '../../core/notifier/id_expiry_module/employee_documents/employee_list_notifier.dart';
import '../../core/notifier/id_expiry_module/vehicle_documents/vehicle_list_notifier.dart';
import '../widget/list_builder_custom_widget.dart';

class DocumentListScreen extends HookWidget {
  const DocumentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalNotifier = context.watch<GeneralNotifier>();
    double screenWidth = MediaQuery.of(context).size.width;
    generalNotifier.checkAxisCount(context: context);

    print(screenWidth);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainAppBarWidget(
              isFirstPage: false,
              title: generalNotifier.getBranchName,
            ),
            kSizedBox20,
            Consumer3<VehicleListNotifier, EmployeeListNotifier,
                    CompanyDocumentListNotifier>(
                builder: (context, vehicleSnapshot, employeeSnapshot,
                    companySnapshot, _) {
              return vehicleSnapshot.getIsLoading ||
                      employeeSnapshot.getIsLoading ||
                      companySnapshot.getIsLoading
                  ? const CircularProgressIndicatorWidget()
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              generalNotifier.getCategoryType ==
                                      CategoryType.VEHICLE
                                  ? "Vehicle Documents"
                                  : generalNotifier.getCategoryType ==
                                          CategoryType.EMPLOYEE
                                      ? "Employee Documents"
                                      : generalNotifier.getCategoryType ==
                                              CategoryType.COMPANY
                                          ? "Company Documents"
                                          : "Documents",
                              style: getSemiBoldStyle(
                                  color: ColorManager.primaryLight,
                                  fontSize: FontSize.s18),
                            ),
                            kSizedBox20,
                            generalNotifier.getCategoryType ==
                                    CategoryType.VEHICLE
                                ? Expanded(
                                    child: ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        height: 1,
                                      );
                                    },
                                    itemCount: vehicleSnapshot
                                            .getVehicles?.result?.length ??
                                        0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final data = vehicleSnapshot
                                          .getVehicles?.result?[index];

                                      return ListBuilderCustomWidget(
                                        title: data?.name ?? "",
                                        documentNumber: data?.numberPlate ?? "",
                                        onTap: () {
                                          generalNotifier.selectedListDocumentId(documentID: data!.id!);
                                          showSnackBar(
                                            context: context,
                                            text: "Document Screen pending",
                                          );
                                        },

                                        onEditTap: (){
                                          generalNotifier.selectedListDocumentId(documentID: data!.id!);
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const DocumentListFormScreen(isEditing: true,)));


                                        },

                                      );
                                    },
                                  ))
                                : generalNotifier.getCategoryType ==
                                        CategoryType.COMPANY
                                    ? Expanded(
                                        child: ListView.separated(
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                            height: 1,
                                          );
                                        },
                                        itemCount: companySnapshot
                                                .getDocuments?.result?.length ??
                                            0,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final data = companySnapshot
                                              .getDocuments?.result?[index];
                                          return ListBuilderCustomWidget(
                                            title: data?.documentType ?? "",
                                            documentNumber:
                                                data?.documentNumber ?? "",
                                            onTap: () {
                                              generalNotifier.selectedDocumentId(documentID: data!.id!);
                  showSnackBar(
                  context: context,
                  text: "Document Screen pending",
                  );

                                            },
                                            onEditTap: (){
                                              generalNotifier.selectedDocumentId(documentID: data!.id!);
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const DocumentListFormScreen(isEditing: true,)));

                                            },

                                          );
                                        },
                                      ))
                                    : generalNotifier.getCategoryType ==
                                            CategoryType.EMPLOYEE
                                        ? Expanded(
                                            child: ListView.separated(
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                                height: 1,
                                              );
                                            },
                                            itemCount: employeeSnapshot
                                                    .getEmployees
                                                    ?.result
                                                    ?.length ??
                                                0,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final data = employeeSnapshot
                                                  .getEmployees?.result?[index];

                                              return ListBuilderCustomWidget(
                                                title: data?.employeeName ?? "",
                                                documentNumber:
                                                    data?.employeeIqama ?? "",
                                                onTap: () {
                                                  generalNotifier.selectedListDocumentId(documentID: data!.id!);

                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const DocumentListFormScreen(isEditing: true,)));

                                                },
                                                onEditTap: (){
                                                  generalNotifier.selectedListDocumentId(documentID: data!.id!);

                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const DocumentListFormScreen(isEditing: true,)));

                                                },

                                              );
                                            },
                                          ))
                                        : kSizedBox
                          ],
                        ),
                      ),
                    );
            }),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentListFormScreen(isEditing: false,))),
          tooltip: 'Increment',
          // backgroundColor: ColorManager.red,
          child:  Icon(Icons.add,color: ColorManager.white,),
        )
    );
  }
}
