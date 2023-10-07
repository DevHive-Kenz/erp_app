
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/core/notifier/customer_crud_notifier/customer_create_notifier.dart';
import 'package:kenz_app/core/notifier/customer_crud_notifier/customer_delete_notifier.dart';
import 'package:kenz_app/core/notifier/customer_crud_notifier/customer_edit_notifier.dart';
import 'package:kenz_app/core/notifier/master_data_notifier/master_data_notifier.dart';
import 'package:kenz_app/core/notifier/profile_notifier/profile_notifier.dart';
import 'package:kenz_app/provider/current_sale_notifier.dart';
import 'package:kenz_app/screens/home_screen/customer_create_screen/widget/checkbox_widget.dart';
import 'package:kenz_app/screens/home_screen/customer_create_screen/widget/row_textfield_widget.dart';
import 'package:kenz_app/screens/widget/Circular_progress_indicator_widget.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import 'package:kenz_app/screens/widget/text_field_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/master_data_model/master_data_values_model.dart';
import '../../widget/appbar_main_widget.dart';

class CustomerCRUDScreen extends HookWidget {
  const CustomerCRUDScreen({super.key,this.isEditable = false});
  final bool isEditable;
  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final nameArabicController = useTextEditingController();
    final address1Controller = useTextEditingController();
    final address1AController = useTextEditingController();
    final address2Controller = useTextEditingController();
    final address2AController = useTextEditingController();
    final crnController = useTextEditingController();
    final vatController = useTextEditingController();
    final priceListController = useTextEditingController();
    final priceListValue = useState<int?>(null);
    final groupController = useTextEditingController();
    final groupValue = useState<int?>(null);
    final regionController = useTextEditingController();
    final regionValue = useState<int?>(null);
    final saleRepController = useTextEditingController();
    final saleRepValue = useState<int?>(null);
    final routeController = useTextEditingController();
    final routeValue = useState<int?>(null);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final customerIDController = useTextEditingController();
    final isCustomer = useState<bool>(false);
    final isVendor = useState<bool>(false);
    final isEmployee = useState<bool>(false);
    final isRep = useState<bool>(false);
    final currentSalesNotifier = context.read<CurrentSaleNotifier>();
    final masterDataNotifier = context.read<MasterDataCustomerNotifier>();
    void assign(){
      nameController.text = currentSalesNotifier.getSelectedCustomer?.name ?? "";
      nameArabicController.text = currentSalesNotifier.getSelectedCustomer?.nameArabic ?? "";
      address1Controller.text = currentSalesNotifier.getSelectedCustomer?.address1 ?? "";
      address1AController.text = currentSalesNotifier.getSelectedCustomer?.address1A ?? "";
      address2AController.text = currentSalesNotifier.getSelectedCustomer?.address2A ?? "";
      address2Controller.text = currentSalesNotifier.getSelectedCustomer?.address2 ?? "";
      crnController.text = currentSalesNotifier.getSelectedCustomer?.crnNumber ?? "";
      vatController.text = currentSalesNotifier.getSelectedCustomer?.vatNumber ?? "";
      isCustomer.value = currentSalesNotifier.getSelectedCustomer?.isCustomer ?? false;
      isVendor.value = currentSalesNotifier.getSelectedCustomer?.isVendor ?? false;
      isEmployee.value = currentSalesNotifier.getSelectedCustomer?.isEmployee ?? false;
      isRep.value = currentSalesNotifier.getSelectedCustomer?.isRep ?? false;
      print(currentSalesNotifier.getSelectedCustomer?.customerID.toString() ?? "0");
      customerIDController.text = currentSalesNotifier.getSelectedCustomer?.customerID.toString() ?? "0";
    }

    useEffect(() {
      Future.microtask(() {
        if(isEditable == true){
          assign();
        }
      },);
      return null;
    },[]);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                MainAppBarWidget(
                    isFirstPage: false,
                    title: isEditable ? "Edit Customer Details" : "Add Customer"
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kSizedBox10,
                      Text("Select Type",style: getBoldStyle(color: ColorManager.primaryLight,fontSize: AppSize.s16),),
                   Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           CheckBoxWidget(valueInCheckBox: isCustomer, title: "Customer",isDisabled: false),
                           CheckBoxWidget(valueInCheckBox: isVendor, title: "Vendor",isDisabled: true,),
                         ],
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,

                         children: [
                           CheckBoxWidget(valueInCheckBox: isEmployee, title: "Employee",isDisabled: true,),
                           CheckBoxWidget(valueInCheckBox: isRep, title: "Rep",isDisabled: true,),
                         ],
                       ),
                     ],
                   ),

                      kSizedBox10,
                      Text("Please Enter Details",style: getBoldStyle(color: ColorManager.primaryLight,fontSize: AppSize.s16),),
                      kSizedBox10,
                      RowTextFields(controller1: nameController,controller2: nameArabicController,title1: "Enter Name",title2: "Enter Name 2",isValidate: true,),
                      kSizedBox10,
                      RowTextFields(controller1: address1Controller,controller2: address1AController,title1: "Enter Address 1",title2: "Enter Address 1 Arabic",isValidate: true,),
                      kSizedBox10,
                      RowTextFields(controller1: address2Controller,controller2: address2AController,title1: "Enter Address 2",title2: "Enter Address 2 Arabic",isValidate: false,),
                      kSizedBox10,
                      RowTextFields(controller1: crnController,controller2: vatController,title1: "Enter CRN",title2: "Enter VAT no",isValidate: false,inputType: TextInputType.number,validator2: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Vat Number';
                        }else if(value.length != 15){
                          return 'Length of VAT Number should be 15 digits';

                        }
                        return null;
                      },),
                      kSizedBox10,
                      RowTextFields(
                        controller1: priceListController,
                        controller2: groupController,
                        title1: "Select Price List",
                        title2: "Select Group",
                        isValidate: false,
                      isReadOnly: true,
                        onTap1: (){
                          showModalBottomSheet(
                              backgroundColor:
                              Colors.transparent,
                              context: context,
                              elevation: 500,
                              isScrollControlled: true,
                              shape:
                              const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: LayoutBuilder(
                                      builder: (BuildContextcontext, BoxConstraints constraints) {
                                        bool isSmallScreen = MediaQuery.of(context).size.width < 800;
                                        double widthFactor = isSmallScreen ? 1.0 : 0.7;
                                        return FractionallySizedBox(
                                          widthFactor: widthFactor,
                                          child: StatefulBuilder(
                                              builder: (BuildContextcontext, setModalState) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: new BorderRadius.only(topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0),
                                                        )),
                                                    height: 200.h,
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: AppPadding.p8),
                                                    child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        kSizedBox15,
                                                        Text(
                                                          "Select the price list",
                                                          style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                                        ),
                                                        kSizedBox10,
                                                        Expanded(
                                                          child: ListView.separated(
                                                              separatorBuilder: (context, index) {
                                                                return const Divider();
                                                              },
                                                              itemCount: masterDataNotifier.getMasterDataModel?.result?.priceList?.length  ?? 0,
                                                              itemBuilder: (context, index) {
                                                                MasterDataValueModel? data =masterDataNotifier.getMasterDataModel?.result?.priceList?[index];
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    priceListValue.value = data?.id;
                                                                    priceListController.text = data?.name ?? "";

                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p8),
                                                                    child:  Text(
                                                                      data?.name ?? "",
                                                                      style: getRegularStyle(color: ColorManager.black, fontSize: FontSize.s14),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                        ),
                                                      ],
                                                    ),),
                                                );
                                              }),
                                        );
                                      }),
                                );
                              });
                        },
                        onTap2: (){
                          showModalBottomSheet(
                              backgroundColor:
                              Colors.transparent,
                              context: context,
                              elevation: 500,
                              isScrollControlled: true,
                              shape:
                              const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: LayoutBuilder(
                                      builder: (BuildContextcontext, BoxConstraints constraints) {
                                        bool isSmallScreen = MediaQuery.of(context).size.width < 800;
                                        double widthFactor = isSmallScreen ? 1.0 : 0.7;
                                        return FractionallySizedBox(
                                          widthFactor: widthFactor,
                                          child: StatefulBuilder(
                                              builder: (BuildContextcontext, setModalState) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: new BorderRadius.only(topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0),
                                                        )),
                                                    height: 200.h,
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: AppPadding.p8),
                                                    child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        kSizedBox15,
                                                        Text(
                                                          "Select the Group",
                                                          style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                                        ),
                                                        kSizedBox10,
                                                        Expanded(
                                                          child: ListView.separated(
                                                              separatorBuilder: (context, index) {
                                                                return const Divider();
                                                              },
                                                              itemCount: masterDataNotifier.getMasterDataModel?.result?.group?.length  ?? 0,
                                                              itemBuilder: (context, index) {
                                                                MasterDataValueModel? data =masterDataNotifier.getMasterDataModel?.result?.group?[index];
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    groupValue.value = data?.id;
                                                                    groupController.text = data?.name ?? "";

                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p8),
                                                                    child:  Text(
                                                                      data?.name ?? "",
                                                                      style: getRegularStyle(color: ColorManager.black, fontSize: FontSize.s14),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                        ),
                                                      ],
                                                    ),),
                                                );
                                              }),
                                        );
                                      }),
                                );
                              });
                        },
                      ),
                      kSizedBox10,
                      RowTextFields(
                        controller1: regionController,
                        controller2: saleRepController,
                        title1: "Select Region",
                        title2: "Select Sale Rep",
                        isValidate: false,
                        isReadOnly: true,
                        onTap1: (){
                          showModalBottomSheet(
                              backgroundColor:
                              Colors.transparent,
                              context: context,
                              elevation: 500,
                              isScrollControlled: true,
                              shape:
                              const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: LayoutBuilder(
                                      builder: (BuildContextcontext, BoxConstraints constraints) {
                                        bool isSmallScreen = MediaQuery.of(context).size.width < 800;
                                        double widthFactor = isSmallScreen ? 1.0 : 0.7;
                                        return FractionallySizedBox(
                                          widthFactor: widthFactor,
                                          child: StatefulBuilder(
                                              builder: (BuildContextcontext, setModalState) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: new BorderRadius.only(topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0),
                                                        )),
                                                    height: 200.h,
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: AppPadding.p8),
                                                    child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        kSizedBox15,
                                                        Text(
                                                          "Select the Region",
                                                          style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                                        ),
                                                        kSizedBox10,

                                                        Expanded(
                                                          child: ListView.separated(
                                                              separatorBuilder: (context, index) {
                                                                return const Divider();
                                                              },
                                                              itemCount: masterDataNotifier.getMasterDataModel?.result?.region?.length  ?? 0,
                                                              itemBuilder: (context, index) {
                                                                MasterDataValueModel? data =masterDataNotifier.getMasterDataModel?.result?.region?[index];
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    regionValue.value = data?.id;
                                                                    regionController.text = data?.name ?? "";
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p8),
                                                                    child:  Text(
                                                                      data?.name ?? "",
                                                                      style: getRegularStyle(color: ColorManager.black, fontSize: FontSize.s14),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                        ),
                                                      ],
                                                    ),),
                                                );
                                              }),
                                        );
                                      }),
                                );
                              });
                        },
                        onTap2: (){
                          showModalBottomSheet(
                              backgroundColor:
                              Colors.transparent,
                              context: context,
                              elevation: 500,
                              isScrollControlled: true,
                              shape:
                              const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: LayoutBuilder(
                                      builder: (BuildContextcontext, BoxConstraints constraints) {
                                        bool isSmallScreen = MediaQuery.of(context).size.width < 800;
                                        double widthFactor = isSmallScreen ? 1.0 : 0.7;
                                        return FractionallySizedBox(
                                          widthFactor: widthFactor,
                                          child: StatefulBuilder(
                                              builder: (BuildContextcontext, setModalState) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: new BorderRadius.only(topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0),
                                                        )),
                                                    height: 200.h,
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: AppPadding.p8),
                                                    child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        kSizedBox15,
                                                        Text(
                                                          "Select the Sale Rep",
                                                          style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                                        ),
                                                        kSizedBox10,

                                                        Expanded(
                                                          child: ListView.separated(
                                                              separatorBuilder: (context, index) {
                                                                return const Divider();
                                                              },
                                                              itemCount: masterDataNotifier.getMasterDataModel?.result?.rep?.length  ?? 0,
                                                              itemBuilder: (context, index) {
                                                                MasterDataValueModel? data =masterDataNotifier.getMasterDataModel?.result?.rep?[index];
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    saleRepValue.value = data?.id;
                                                                    saleRepController.text = data?.name ?? "";

                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p8),
                                                                    child:  Text(
                                                                      data?.name ?? "",
                                                                      style: getRegularStyle(color: ColorManager.black, fontSize: FontSize.s14),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                        ),
                                                      ],
                                                    ),),
                                                );
                                              }),
                                        );
                                      }),
                                );
                              });
                        },
                      ),
                      kSizedBox10,
                      TextFormFieldCustom(
                        controller: routeController,
                        hintName: "Select Route",
                        isValidate: false,
                        isReadOnly: true,
                        onTap:  (){
                          showModalBottomSheet(
                              backgroundColor:
                              Colors.transparent,
                              context: context,
                              elevation: 500,
                              isScrollControlled: true,
                              shape:
                              const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.hardEdge,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: LayoutBuilder(
                                      builder: (BuildContextcontext, BoxConstraints constraints) {
                                        bool isSmallScreen = MediaQuery.of(context).size.width < 800;
                                        double widthFactor = isSmallScreen ? 1.0 : 0.7;
                                        return FractionallySizedBox(
                                          widthFactor: widthFactor,
                                          child: StatefulBuilder(
                                              builder: (BuildContextcontext, setModalState) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: new BorderRadius.only(topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0),
                                                        )),
                                                    height: 200.h,
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: AppPadding.p8),
                                                    child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        kSizedBox15,
                                                        Text(
                                                          "Select the Route",
                                                          style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                                        ),
                                                        kSizedBox10,

                                                        Expanded(
                                                          child: ListView.separated(
                                                              separatorBuilder: (context, index) {
                                                                return const Divider();
                                                              },
                                                              itemCount: masterDataNotifier.getMasterDataModel?.result?.route?.length  ?? 0,
                                                              itemBuilder: (context, index) {
                                                                MasterDataValueModel? data =masterDataNotifier.getMasterDataModel?.result?.route?[index];
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    routeValue.value = data?.id;
                                                                    routeController.text = data?.name ?? "";
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Container(
                                                                    padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p8),
                                                                    child:  Text(
                                                                      data?.name ?? "",
                                                                      style: getRegularStyle(color: ColorManager.black, fontSize: FontSize.s14),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                        ),
                                                      ],
                                                    ),),
                                                );
                                              }),
                                        );
                                      }),
                                );
                              });
                        },
                      ),
                     kSizedBox20,
                      Center(child: Consumer3<CustomerCreateNotifier,CustomerEditNotifier,CustomerDeleteNotifier>(
                        builder: (context, snapshotCreate,snapshotEdit,snapshotDelete,_) {
                          return snapshotCreate.getIsLoading || snapshotEdit.getIsLoading || snapshotDelete.getIsLoading

                              ? const CircularProgressIndicatorWidget() :

                          isEditable ?
                              Column(
                                children: [
                                  CustomButton(onTap: (){
                                    if(formKey.currentState?.validate() ?? false) {
                                      snapshotEdit.customerEdit(context: context,
                                        name: nameController.text,
                                        nameA: nameArabicController.text,
                                        address1: address1Controller.text,
                                        address1A: address1AController.text,
                                        address2: address2Controller.text,
                                        address2A: address2AController.text,
                                        crn: crnController.text,
                                        vat: vatController.text,
                                        isCustomer: isCustomer.value,
                                        isVendor: isVendor.value,
                                        isEmployee: isEmployee.value,
                                        isRep: isRep.value,
                                        userID: context.read<ProfileNotifier>().getProfile?.result?[0].userId ?? 0, customerID: customerIDController.text,
                                      rep: saleRepValue.value,
                                      region: regionValue.value,
                                      priceList: priceListValue.value,
                                      group: groupValue.value,
                                      route: routeValue.value,
                                    );
                                    }

                                  }, title: "Update"),
                                  kSizedBox10,
                                  Text("-------OR-------",style: getBoldStyle(color: ColorManager.primaryLight),),
                                  kSizedBox10,
                                  InkWell(onTap: (){
                                    snapshotDelete.customerDelete(context: context, customerID: customerIDController.text);
                                  }, child: Icon(Icons.delete,color: ColorManager.red,size: FontSize.s30,))
                                ],
                              )
                              :CustomButton(onTap: (){
                                if(isCustomer.value){
                                  if(formKey.currentState?.validate() ?? false){
                                    snapshotCreate.customerCreate(context: context,
                                      name: nameController.text,
                                      nameA: nameArabicController.text,
                                      address1: address1Controller.text,
                                      address1A: address1AController.text,
                                      address2: address2Controller.text,
                                      address2A: address2AController.text,
                                      crn: crnController.text,
                                      vat: vatController.text,
                                      isCustomer: isCustomer.value,
                                      isVendor: isVendor.value,
                                      isEmployee: isEmployee.value,
                                      isRep: isRep.value,
                                      userID: context.read<ProfileNotifier>().getProfile?.result?[0].userId ?? 0,
                                      rep: saleRepValue.value,
                                      region: regionValue.value,
                                      priceList: priceListValue.value,
                                      group: groupValue.value,
                                      route: routeValue.value,
                                    );

                                  }

                                }else{
                                  showSnackBar(context: context, text: "Please Select Type, eg Customer.");
                                }


                          }, title: "Continue");
                        }
                      )),
                      kSizedBox20,

                    ],
                  ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


