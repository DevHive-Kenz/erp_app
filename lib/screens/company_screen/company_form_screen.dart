import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/core/notifier/company/company_List_notifier.dart';
import 'package:kenz_app/core/notifier/company/company_delete_notifier.dart';
import 'package:kenz_app/core/notifier/company/company_update_notifier.dart';
import 'package:kenz_app/screens/widget/Circular_progress_indicator_widget.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../core/notifier/company/company_create_notifier.dart';
import '../widget/appbar_main_widget.dart';
import '../widget/text_field_widget.dart';

class CompanyFormScreen extends HookWidget {
  const CompanyFormScreen({Key? key,this.isEditing=false}) : super(key: key);
 final bool isEditing;
  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final companyCreateNotifier = context.watch<CompanyCreateNotifier>();
    final companyUpdateNotifier = context.watch<CompanyUpdateNotifier>();
    final companyDeleteNotifier = context.watch<CompanyDeleteNotifier>();
    final companyListNotifier = context.watch<CompaniesListNotifier>();
    final companyListReadNotifier = context.read<CompaniesListNotifier>();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.h),
          child:  MainAppBarWidget(isFirstPage: false,title: "Add Company",),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kSizedBox20,
                  Text(isEditing ?"Enter Details to Edit":"Enter Details",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),
                  kSizedBox20,
                  TextFormFieldCustom(
                    controller: nameController,
                    hintName: "Enter Company Name",
                    icon: Icons.local_convenience_store,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter the value";
                      }
                      return null;
                    },
                  ),
                  kSizedBox50,
               companyCreateNotifier.getIsLoading || companyUpdateNotifier.getIsLoading || companyListNotifier.getIsLoading   || companyDeleteNotifier.getIsLoading  ? const CircularProgressIndicatorWidget() : Center(
                 child: CustomButton(
                            onTap: () async {
                             if(formKey.currentState!.validate()){
                               if(isEditing){
                                 await   companyUpdateNotifier.updateCompany(context: context, name: nameController.text).then((value) {
                                 nameController.text = "";
                                 });

                               }else{
                                 await      companyCreateNotifier.postCompany(context: context, name: nameController.text);
                                 nameController.text = "";

                               }
                             }
                            },
                          title: isEditing ? "Update":"Continue",
                        ),
               ),
                 kSizedBox10,
                  isEditing ?   Center(
                   child: Column(
                     children: [
                       Text("-----OR-----",style: getSemiBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s18),),
                  IconButton(onPressed: () async {
                  await  companyDeleteNotifier.deleteCompany(context: context);
                       }, icon: Icon(Icons.delete,color: ColorManager.red,size: FontSize.s30,))
                     ],
                   ),
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
