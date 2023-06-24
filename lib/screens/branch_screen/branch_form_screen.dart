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
import '../../core/notifier/branch/branch_create_notifier.dart';
import '../../core/notifier/branch/branch_delete_notifier.dart';
import '../../core/notifier/branch/branch_list_notifier.dart';
import '../../core/notifier/branch/branch_update_notifier.dart';
import '../../core/notifier/company/company_create_notifier.dart';
import '../widget/appbar_main_widget.dart';
import '../widget/text_field_widget.dart';

class BranchFormScreen extends HookWidget {
  const BranchFormScreen({Key? key,this.isEditing=false}) : super(key: key);
 final bool isEditing;
  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final branchCreateNotifier = context.watch<BranchCreateNotifier>();
    final branchUpdateNotifier = context.watch<BranchUpdateNotifier>();
    final branchDeleteNotifier = context.watch<BranchDeleteNotifier>();
    final branchListNotifier = context.watch<BranchListNotifier>();
    final branchListReadNotifier = context.read<BranchListNotifier>();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kSizedBox20,
                  Text(isEditing ?"Enter Details to Edit":"Enter Details",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),
                  kSizedBox20,
                  TextFormFieldCustom(
                    controller: nameController,
                    hintName: "Enter Branch Name",
                    icon: Icons.local_convenience_store,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter the value";
                      }
                      return null;
                    },
                  ),
                  kSizedBox50,
               branchCreateNotifier.getIsLoading || branchUpdateNotifier.getIsLoading || branchListNotifier.getIsLoading   || branchDeleteNotifier.getIsLoading  ? const CircularProgressIndicatorWidget() : Center(
                 child: CustomButton(
                            onTap: () async {
                             if(formKey.currentState!.validate()){
                               if(isEditing){
                                 await   branchUpdateNotifier.updateBranch(context: context, name: nameController.text);
                                 nameController.text = "";

                               }else{
                                 await  branchCreateNotifier.postBranch(context: context, name: nameController.text);
                                 nameController.text = "";
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
                     await  branchDeleteNotifier.deleteBranch(context: context);
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
