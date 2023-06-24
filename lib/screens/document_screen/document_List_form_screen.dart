import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/core/api/id_expiry_module/company_document/documents/company_create_api.dart';
import 'package:kenz_app/core/notifier/company/company_List_notifier.dart';
import 'package:kenz_app/core/notifier/company/company_delete_notifier.dart';
import 'package:kenz_app/core/notifier/company/company_update_notifier.dart';
import 'package:kenz_app/screens/widget/Circular_progress_indicator_widget.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../core/notifier/branch/branch_create_notifier.dart';
import '../../core/notifier/branch/branch_delete_notifier.dart';
import '../../core/notifier/branch/branch_list_notifier.dart';
import '../../core/notifier/branch/branch_update_notifier.dart';
import '../../core/notifier/company/company_create_notifier.dart';
import '../../core/notifier/id_expiry_module/company_documents/company_document_create_notifier.dart';
import '../../core/notifier/id_expiry_module/company_documents/company_document_delete_notifier.dart';
import '../../core/notifier/id_expiry_module/company_documents/company_document_list_notifier.dart';
import '../../core/notifier/id_expiry_module/company_documents/company_document_update_notifier.dart';
import '../../core/notifier/id_expiry_module/employee_documents/employee_create_notifier.dart';
import '../../core/notifier/id_expiry_module/employee_documents/employee_delete_notifier.dart';
import '../../core/notifier/id_expiry_module/employee_documents/employee_list_notifier.dart';
import '../../core/notifier/id_expiry_module/employee_documents/employee_update_notifier.dart';
import '../../core/notifier/id_expiry_module/vehicle_documents/vehicle_create_notifier.dart';
import '../../core/notifier/id_expiry_module/vehicle_documents/vehicle_delete_notifier.dart';
import '../../core/notifier/id_expiry_module/vehicle_documents/vehicle_list_notifier.dart';
import '../../core/notifier/id_expiry_module/vehicle_documents/vehicle_update_notifier.dart';
import '../../provider/general_notifier.dart';
import '../widget/appbar_main_widget.dart';
import '../widget/text_field_widget.dart';

class DocumentListFormScreen extends HookWidget {
  const DocumentListFormScreen({Key? key,this.isEditing=false}) : super(key: key);
 final bool isEditing;
  @override
  Widget build(BuildContext context) {
    final documentNameController = useTextEditingController();
    final expiryController = useTextEditingController();
    final documentNumberController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectDate = useState<DateTime>(DateTime.now());
    final generalNotifier = context.watch<GeneralNotifier>();


    Future<void> _selectDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: ColorManager.primaryLight, // Set the text color
                onPrimary: Colors.white, // Set the background color
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black, // Set the text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );


      if (picked != null && picked != selectDate.value) {

        selectDate.value = picked;
        // Format the date
        final formattedDate = DateFormat('yyyy-MM-dd').format(selectDate.value);
        print('Selected Date: $formattedDate');
        expiryController.text= formattedDate;

      }
    }
    
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.h),
          child:  MainAppBarWidget(isFirstPage: false,title: "Add Branch",),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                   generalNotifier.getCategoryType == CategoryType.COMPANY ?
                  Consumer4<CompanyCreateDocumentNotifier,CompanyDocumentDeleteNotifier,CompanyUpdateDocumentNotifier, CompanyDocumentListNotifier>(
                    builder: (context, createSnapshot,deleteSnapshot,updateSnapshot,listSnapshot,_) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kSizedBox20,
                          Text(isEditing ?"Enter Details to Edit":"Enter Details",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),
                          kSizedBox20,
                          TextFormFieldCustom(
                            controller: documentNameController,
                            hintName: "Enter Document Name",
                            icon: Icons.description_rounded,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Please enter the value";
                              }
                              return null;
                            },
                          ),
                          kSizedBox10,
                          TextFormFieldCustom(
                            controller: documentNumberController,
                            hintName: "Enter Document ID",
                            icon: Icons.description_rounded,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Please enter the value";
                              }
                              return null;
                            },
                          ),
                          kSizedBox10,

                          TextFormFieldCustom(
                            controller: expiryController,
                            hintName: "Select Expiry Date",
                            icon: Icons.calendar_month_rounded,
                            onTap: _selectDate,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Please enter the value";
                              }
                              return null;
                            },
                          ),
                          kSizedBox50,
                       createSnapshot.getIsLoading || deleteSnapshot.getIsLoading || listSnapshot.getIsLoading   || deleteSnapshot.getIsLoading  ? const CircularProgressIndicatorWidget() : Center(
                         child: CustomButton(
                                    onTap: () async {
                                     if(formKey.currentState!.validate()){
                                       if(isEditing){
                                         await   updateSnapshot.updateCompanyDocument(context: context, expiry: expiryController.text, documentType: documentNameController.text, documentNumber: documentNumberController.text);
                                         documentNameController.text = "";
                                         expiryController.text = "";
                                         documentNumberController.text = "";

                                       }else{
                                         await  createSnapshot.postCompanyDocument(context: context, expiry: expiryController.text, documentType: documentNameController.text, documentNumber: documentNumberController.text);
                                         documentNameController.text = "";
                                         expiryController.text = "";
                                         documentNumberController.text = "";
                                       }
                                     }
                                    },
                                  title: isEditing ? "Update":"Continue",
                                ),
                       ),
                         kSizedBox10,
                          isEditing ?  Center(
                           child: Column(
                             children: [
                               Text("-----OR-----",style: getSemiBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s18),),
                          IconButton(onPressed: () async {
                             await  deleteSnapshot.deleteCompanyDocument(context: context);
                               }, icon: Icon(Icons.delete,color: ColorManager.red,size: FontSize.s30,))
                             ],
                           ),
                         ):kSizedBox

                        ],
                      );
                    }
                  )
               :   generalNotifier.getCategoryType == CategoryType.VEHICLE ?
                  Consumer4<VehicleCreateNotifier,VehicleDeleteNotifier,VehicleUpdateNotifier, VehicleListNotifier>(

                      builder: (context, createSnapshot,deleteSnapshot,updateSnapshot,listSnapshot,_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kSizedBox20,
                            Text(isEditing ?"Enter Details to Edit":"Enter Details",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),
                            kSizedBox20,
                            TextFormFieldCustom(
                              controller: documentNameController,
                              hintName: "Enter Document Name",
                              icon: Icons.description_rounded,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Please enter the value";
                                }
                                return null;
                              },
                            ),
                            kSizedBox10,
                            TextFormFieldCustom(
                              controller: documentNumberController,
                              hintName: "Enter Car Number",
                              icon: Icons.description_rounded,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Please enter the value";
                                }
                                return null;
                              },
                            ),
                            kSizedBox50,
                            createSnapshot.getIsLoading || deleteSnapshot.getIsLoading || listSnapshot.getIsLoading   || deleteSnapshot.getIsLoading  ? const CircularProgressIndicatorWidget() : Center(
                              child: CustomButton(
                                onTap: () async {
                                  if(formKey.currentState!.validate()){
                                    if(isEditing){
                                      await   updateSnapshot.updateVehicle(context: context, name: documentNameController.text, numberPlate: documentNumberController.text,);
                                      documentNameController.text = "";
                                      documentNumberController.text = "";

                                    }else{
                                      await  createSnapshot.createVehicle(context: context, name: documentNameController.text, numberPlate: documentNumberController.text);
                                      documentNameController.text = "";
                                      documentNumberController.text = "";
                                    }
                                  }
                                },
                                title: isEditing ? "Update":"Continue",
                              ),
                            ),
                            kSizedBox10,
                            isEditing ?  Center(
                              child: Column(
                                children: [
                                  Text("-----OR-----",style: getSemiBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s18),),
                                  IconButton(onPressed: () async {
                                    await  deleteSnapshot.deleteVehicle(context: context, );
                                  }, icon: Icon(Icons.delete,color: ColorManager.red,size: FontSize.s30,))
                                ],
                              ),
                            ):kSizedBox

                          ],
                        );
                      }
                  )
                       :   generalNotifier.getCategoryType == CategoryType.EMPLOYEE ?
                   Consumer4<EmployeeCreateNotifier,EmployeeDeleteNotifier,EmployeeUpdateNotifier, EmployeeListNotifier>(
                      builder: (context, createSnapshot,deleteSnapshot,updateSnapshot,listSnapshot,_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kSizedBox20,
                            Text(isEditing ?"Enter Details to Edit":"Enter Details",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),
                            kSizedBox20,
                            TextFormFieldCustom(
                              controller: documentNameController,
                              hintName: "Enter Employee Name",
                              icon: Icons.description_rounded,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Please enter the value";
                                }
                                return null;
                              },
                            ),
                            kSizedBox10,
                            TextFormFieldCustom(
                              controller: documentNumberController,
                              hintName: "Enter Iqama/ID Number",
                              icon: Icons.description_rounded,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Please enter the value";
                                }
                                return null;
                              },
                            ),
                            kSizedBox50,
                            createSnapshot.getIsLoading || deleteSnapshot.getIsLoading || listSnapshot.getIsLoading   || deleteSnapshot.getIsLoading  ? const CircularProgressIndicatorWidget() : Center(
                              child: CustomButton(
                                onTap: () async {
                                  if(formKey.currentState!.validate()){
                                    if(isEditing){
                                      await   updateSnapshot.updateEmployee(context: context,iqama:  documentNumberController.text, employeeName: documentNameController.text,);
                                      documentNameController.text = "";
                                      documentNumberController.text = "";

                                    }else{
                                      await  createSnapshot.createEmployee(context: context, iqama: documentNumberController.text, employeeName: documentNameController.text);
                                      documentNameController.text = "";
                                      documentNumberController.text = "";
                                    }
                                  }
                                },
                                title: isEditing ? "Update":"Continue",
                              ),
                            ),
                            kSizedBox10,
                            isEditing ?  Center(
                              child: Column(
                                children: [
                                  Text("-----OR-----",style: getSemiBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s18),),
                                  IconButton(onPressed: () async {
                                    await  deleteSnapshot.deleteEmployee(context: context, );
                                  }, icon: Icon(Icons.delete,color: ColorManager.red,size: FontSize.s30,))
                                ],
                              ),
                            ):kSizedBox

                          ],
                        );
                      }
                  ):kSizedBox
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}
