import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/core/notifier/product_notifier/product_notifier.dart';
import 'package:kenz_app/provider/current_sale_notifier.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model/product_items_model.dart';
import '../../../models/product_model/product_result_model.dart';
import '../../../models/product_model/product_unit_conversion_model.dart';
import '../../../provider/search_notifier.dart';
import '../../widget/appbar_main_widget.dart';
import '../../widget/text_field_widget.dart';





class SalesAddScreen extends HookWidget {
  const SalesAddScreen({super.key,this.editIndex});
  final int? editIndex;
  @override
  Widget build(BuildContext context) {
    final searchProduct = Provider.of<SearchProvider>(context);
    final productNotifier = context.read<ProductNotifier>();
    final currentNotifier = context.read<CurrentSaleNotifier>();
    final itemNameController = useTextEditingController();
    final qtyController  = useTextEditingController();
    final unitController = useTextEditingController();
    final rateController = useTextEditingController();
    final priceListController = useTextEditingController();
    ScrollController scrollController = ScrollController();

    final qtyFocus = useFocusNode();
    final discountPercentController = useTextEditingController(text: "0.00");
    final discountFixedController = useTextEditingController(text: "0.00");
    final taxPercentController = useTextEditingController(text: "0% VAT");
    ValueNotifier<double> subtotal = useState<double>(0.00);
    ValueNotifier<double> disTotal = useState<double>(0.00);
    ValueNotifier<double> vatTotal = useState<double>(0.00);


    void preFillData(){
      if(editIndex != null){
        // itemNameController.text = currentNotifier.getItemList[editIndex!]["item"];
        // qtyController.text = currentNotifier.getItemList[editIndex!]["quantity"].toString();
        // unitController.text = currentNotifier.getItemList[editIndex!]["unit"].toString();
        // rateController.text = currentNotifier.getItemList[editIndex!]["price"].toString();
        // priceListController.text =currentNotifier.getItemList[editIndex!]["priceList"].toString();
        // discountPercentController.text =currentNotifier.getItemList[editIndex!]["discount"].toString();
        // discountFixedController.text = currentNotifier.getItemList[editIndex!]["discountFixed"].toString();
        // taxPercentController.text = "${currentNotifier.getItemList[editIndex!]["tax"]}% VAT";
        // subtotal.value = currentNotifier.getItemList[editIndex!]["subTotal"];
        // vatTotal.value = currentNotifier.getItemList[editIndex!]["tax_amount"];
        // disTotal.value = currentNotifier.getItemList[editIndex!]["discount_amount"];
        // ///notifier setting
        // currentNotifier.setVatPercent = currentNotifier.getItemList[editIndex!]["tax"].toString();
        // currentNotifier.setProduct = currentNotifier.getItemList[editIndex!]["productModel"];
        // currentNotifier.setPriceList = currentNotifier.getItemList[editIndex!]["priceListModel"];
        // currentNotifier.setConversion = currentNotifier.getItemList[editIndex!]["conversionModel"];
        // currentNotifier.setPriceFromConversion = currentNotifier.getItemList[editIndex!]["fromConversionItemModel"];

      }
    }

    useEffect(() {

      Future.microtask(() {
        preFillData();
        currentNotifier.clearVariables();
      },);

      return null;
    },[]);

    void clearVariables(){
      itemNameController.clear();
      qtyController.clear();
      unitController.clear();
      rateController.clear();
      priceListController.clear();
      discountPercentController.text="0.00";
      discountFixedController.text="0.00";
      taxPercentController.text="0% VAT";
      disTotal.value = 0.00;
      vatTotal.value = 0.00;
    }



    ///select unit
    void selectUnitFunc(){
      if(priceListController.text.isNotEmpty){
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
                                  height: 300.h,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppPadding.p8),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      kSizedBox15,
                                      Text(
                                        "Select the unit",
                                        style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                      ),
                                      kSizedBox30,
                                      Expanded(
                                        child: ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return const Divider();
                                            },
                                            itemCount: currentNotifier.getUOMWithBase.length ,
                                            itemBuilder: (context, index) {
                                              ProductUnitConversionDataModel? data =currentNotifier.getUOMWithBase[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  currentNotifier.setConversion = data;
                                                  taxPercentController.clear();
                                                  disTotal.value = 0.00;
                                                  vatTotal.value = 0.00;
                                                  data.items?.forEach((element) {
                                                    if(element.id.toString() == currentNotifier.getSelectedPriceList?.id){
                                                      currentNotifier.setPriceFromConversion = element;
                                                    }
                                                  });
                                                  qtyController.text = "1";
                                                  rateController.text = currentNotifier.getSelectedPriceFromConvItems?.standardLimitPrice ?? "0.00";
                                                  unitController.text = data.toUnitName ?? "";
                                                  subtotal.value = double.parse(rateController.text ?? "0.00");
                                                  searchProduct.changeSearchString("");
                                                  qtyFocus.requestFocus();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p8),
                                                  child:  Text(
                                                    data?.toUnitName ?? "",
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
      }else{
        showAwesomeDialogue(title: "Info", content: "Please Select PriceList before continuing", type: DialogType.INFO);
      }

    }

    ///select price list
    void selectPriceListFun(){
      if(itemNameController.text.isNotEmpty){
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
            builder:
                (BuildContext context) {
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
                                  height: 300.h,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppPadding.p8),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      kSizedBox15,
                                      Text(
                                        "Select the Price List",
                                        style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                      ),
                                      kSizedBox10,
                                      Expanded(
                                        child: ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return const Divider();
                                            },
                                            itemCount: currentNotifier.getSelectedProduct?.basePriceData?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              ProductItemsModel? data = currentNotifier.getSelectedProduct?.basePriceData?[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  taxPercentController.clear();
                                                  disTotal.value = 0.00;
                                                  vatTotal.value = 0.00;
                                                  currentNotifier.setPriceList = data!;
                                                   print("check ${currentNotifier.getSelectedProduct?.unitConversionData}");
                                                  // List<ProductUnitConversionDataModel> uomWithBase = currentNotifier.getSelectedProduct?.unitConversionData ?? [];
                                                  //
                                                  // uomWithBase.add(
                                                  //       ProductUnitConversionDataModel(
                                                  //         price: null,
                                                  //         qty: "1",
                                                  //         barcode: [],
                                                  //         toUnit: currentNotifier.getSelectedProduct?.baseUnitName ?? "",
                                                  //         toUnitName: currentNotifier.getSelectedProduct?.baseUnitName ?? "",
                                                  //         items: currentNotifier.getSelectedProduct?.basePriceData ?? [],
                                                  //       )
                                                  //   );

                                                  priceListController.text = data.name ?? "";
                                                  searchProduct.changeSearchString("");
                                                  Navigator.pop(context);
                                                  selectUnitFunc();

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
      }else{
        showAwesomeDialogue(title: "Info", content: "Please Select Item before continuing", type: DialogType.INFO);
      }

    }

    ///item select
    void productDetailFun(){
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
          builder:
              (BuildContext context) {
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
                                height: 500.h,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p8),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kSizedBox15,
                                    Text(
                                      "Search Product",
                                      style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                    ),
                                    kSizedBox10,
                                    CupertinoSearchTextField(
                                      onChanged: (value) {
                                        setModalState(() {
                                          searchProduct.changeSearchString(value);
                                        });
                                      },
                                      autofocus: true,
                                    ),
                                    kSizedBox20,
                                    Expanded(
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return const Divider();
                                          },
                                          itemCount: searchProduct.getProductList.length,
                                          itemBuilder: (context, index) {
                                            ProductResultModel data = searchProduct.getProductList[index];
                                            return GestureDetector(
                                              onTap: () {
                                                clearVariables();
                                                currentNotifier.clearVariables();
                                                currentNotifier.setProduct = data;
                                                print("qwe2 ${data.unitConversionData?.length}");

                                                itemNameController.text = "${data.name}";
                                                searchProduct.changeSearchString("");
                                                Navigator.pop(context);
                                                selectPriceListFun();

                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p8),
                                                child:  Text(
                                                  "${data.name.toString()}\n${data.nameArabic.toString()}",
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
    }

    ///select vat
    void selectVat(){
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
            List vatList = ["0% VAT","5% VAT","15% VAT"];
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
                                height: 300.h,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p8),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kSizedBox15,
                                    Text(
                                      "Select the Tax",
                                      style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                    ),
                                    kSizedBox30,
                                    Expanded(
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return const Divider();
                                          },
                                          itemCount:vatList.length,
                                          itemBuilder: (context, index) {
                                            String data = vatList[index];
                                            return GestureDetector(
                                              onTap: () {
                                                RegExp regExp = RegExp(r'\d+(\.\d+)?');
                                                Match? firstMatch = regExp.firstMatch(data);
                                                print(firstMatch?.group(0));
                                                currentNotifier.setVatPercent = firstMatch?.group(0) ?? "0.00";
                                                taxPercentController.text = data;
                                                vatTotal.value = (subtotal.value - disTotal.value) * (currentNotifier.getVatPercent / 100);
                                                searchProduct.changeSearchString("");
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: AppPadding.p8, horizontal: AppPadding.p8),
                                                child:  Text(
                                                  data,
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
    }

    return  Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            controller: scrollController,

            child: Column(
              children: [
                MainAppBarWidget(
                    isFirstPage: false,
                    title: editIndex != null ? "Edit Product":"Add the product"
                ),
                kSizedBox10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Container(
                      padding:const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p12) ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Enter Product Details",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s16),),
                          kSizedBox20,
                          TextFormFieldCustom(
                            controller: itemNameController,
                            hintName: "Select Item *",
                            isReadOnly: true,
                            onTap: (){
                              productDetailFun();
                            },
                          ),
                          kSizedBox15,
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: priceListController,
                                  hintName: "Select Price List *",
                                  isReadOnly: true,
                                  onTap: (){
                                    selectPriceListFun();
                                  },
                                ),
                              ),
                              kSizedW10,
                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: unitController,
                                  hintName: "Select Unit *",

                                  isReadOnly: true,
                                  onTap: (){
                                    selectUnitFunc();
                                  },
                                ),
                              ),
                            ],
                          ),
                          kSizedBox15,
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: qtyController,
                                  inputType: TextInputType.number,
                                  hintName: "Quantity *",
                                  focus: qtyFocus,
                                  onChanged: (value){
                                    if(value.isNotEmpty){
                                      double val = double.parse(value);
                                      if(val>0 && rateController.text.isNotEmpty){
                                        subtotal.value = val * double.parse(rateController.text);
                                        disTotal.value = subtotal.value * (double.parse(discountPercentController.text) / 100);
                                        vatTotal.value = (subtotal.value - disTotal.value) * (currentNotifier.getVatPercent / 100);
                                      }else{
                                        showAwesomeDialogue(title: "INFO", content: "Quantity & Rate should be larger than zero", type: DialogType.INFO);
                                        qtyController.clear();
                                      }
                                    }

                                  },
                                ),
                              ),
                              kSizedW10,
                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: rateController,
                                  inputType: TextInputType.number,
                                  hintName: "Rate ",
                                  validator:  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter rate';
                                    }
                                 //    else if (double.parse(value) > double.parse(currentNotifier.getSelectedPriceFromConvItems?.maxLimitPrice ?? "0.00")){
                                 //      // showAwesomeDialogue(title: "Warning", content: 'Please enter a price below \n ${currentNotifier.getSelectedPriceFromConv?.maxLimitPrice ?? "0.00"}', type: DialogType.WARNING);
                                 //
                                 //      return 'Please enter a price below ${currentNotifier.getSelectedPriceFromConvItems?.maxLimitPrice ?? "0.00"}';
                                 //    }else if(double.parse(value) < double.parse(currentNotifier.getSelectedPriceFromConvItems?.lowLimitPrice ?? "0.00")){
                                 // // showAwesomeDialogue(title: "Warning", content: 'Please enter a price above \n ${currentNotifier.getSelectedPriceFromConv?.lowLimitPrice ?? "0.00"}', type: DialogType.WARNING);
                                 //    return 'Please enter a price above \n ${currentNotifier.getSelectedPriceFromConvItems?.lowLimitPrice ?? "0.00"}';
                                 //    }
                                    return null;
                                  },
                                  onChanged: (value){
                                    if(value.isNotEmpty){
                                      double val = double.parse(value);
                                      subtotal.value = val * double.parse(qtyController.text);
                                      disTotal.value = subtotal.value * (double.parse(discountPercentController.text) / 100);
                                      vatTotal.value = (subtotal.value - disTotal.value) * (currentNotifier.getVatPercent / 100);

                                      // if(val>0 && qtyController.text.isNotEmpty){
                                      //   subtotal.value = val * double.parse(qtyController.text);
                                      //   disTotal.value = subtotal.value * (double.parse(discountPercentController.text) / 100);
                                      //   vatTotal.value = (subtotal.value - disTotal.value) * (currentNotifier.getVatPercent / 100);
                                      //
                                      // }else{
                                      //   showAwesomeDialogue(title: "INFO", content: "Rate & Quantity should be larger than zero", type: DialogType.INFO);
                                      //   qtyController.clear();
                                      // }
                                    }

                                  },
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                  ),
                ),
                kSizedBox10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Container(
                    padding:const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p12) ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Totals & Taxes",style: getBoldStyle(color: ColorManager.grey3,fontSize: FontSize.s16),),

                        kSizedBox15,
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldCustom(
                                controller: discountPercentController,
                                hintName:"Discount (%)",
                                inputType: TextInputType.number,
                                onTap: (){
                                  SchedulerBinding.instance.addPostFrameCallback((_) {
                                    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
                                  });
                                },
                                onChanged: (value){
                                  discountFixedController.text = "0.00";
                                  RegExp numericRegex = RegExp(r'^[0-9]*\.?[0-9]*$');
                                   print(value.isNotEmpty);
                                   print(value != ".");
                                  if(value.isNotEmpty && value != "." ){
                                    if(numericRegex.hasMatch(value)) {
                                      disTotal.value = subtotal.value * (double.parse(discountPercentController.text) / 100);
                                      vatTotal.value = (subtotal.value - disTotal.value) * (currentNotifier.getVatPercent / 100);

                                    }else{
                                      discountPercentController.text=="0.00";
                                      showAwesomeDialogue(title: "Input Error", content: "Only 'digits(0-9)' and '.' is allowed in this field", type: DialogType.INFO);
                                    }
                                  }else{
                                    disTotal.value = 0.00;
                                  }
                                },
                              ),
                            ),
                            kSizedW10,
                            Expanded(
                              child: TextFormFieldCustom(
                                controller: discountFixedController,
                                hintName: "Discount (Fixed)",
                                inputType: TextInputType.number,
                                onTap: (){
                                  SchedulerBinding.instance.addPostFrameCallback((_) {
                                    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
                                  });
                                },
                                onChanged: (value){
                                  discountPercentController.text = "0.00";
                                  RegExp numericRegex = RegExp(r'^[0-9]*\.?[0-9]*$');

                                  if(value.isNotEmpty && value != "." ){
                                    if(numericRegex.hasMatch(value)) {
                                      disTotal.value = double.parse(value);
                                      vatTotal.value = (subtotal.value - disTotal.value) * (currentNotifier.getVatPercent / 100);

                                    }else{
                                      discountFixedController.text=="0.00";
                                      showAwesomeDialogue(title: "Input Error", content: "Only 'digits(0-9)' and '.' is allowed in this field", type: DialogType.INFO);
                                    }
                                  }else{
                                    disTotal.value = 0.00;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        kSizedBox15,
                        TextFormFieldCustom(
                          controller: taxPercentController,
                          hintName:"Select Tax % *",
                          isReadOnly: true,
                          onTap: (){
                            selectVat();
                          },
                        ),
                        kSizedBox15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal (Rate x Qty)",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Text("${subtotal.value.toStringAsFixed(2)} SAR",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                          ],
                        ),
                        kSizedBox15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Discount",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Text("${disTotal.value.toStringAsFixed(2)} SAR",style: getSemiBoldStyle(color: Colors.red,fontSize: FontSize.s14),),
                          ],
                        ),
                        kSizedBox15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("VAT",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Text("${vatTotal.value.toStringAsFixed(2)} SAR",style: getSemiBoldStyle(color: Colors.orange,fontSize: FontSize.s14),),
                          ],
                        ),
                        kSizedBox15,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Amount:",style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s14),),
                            Text("${(subtotal.value + vatTotal.value - disTotal.value).toStringAsFixed(2) } SAR",style:  GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  shadows: [
                                    Shadow(
                                        color: ColorManager.green,
                                        offset: Offset(0, -5))
                                  ],
                                  fontSize: FontSize.s16,
                                  color: Colors.transparent,
                                  decorationColor: ColorManager.black,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dashed,
                                )
                            )),
                          ],
                        ),
                        kSizedBox20,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: CustomButton(onTap: (){
                                if(editIndex !=null){
                                  currentNotifier.updateProductList({
                                    "item": itemNameController.text,
                                    "quantity": double.parse(qtyController.text),
                                    "unit":unitController.text,
                                    "price": double.parse(rateController.text),
                                    "tax":currentNotifier.getVatPercent,
                                    "tax_amount":vatTotal.value,
                                    "discount": double.parse(discountPercentController.text),
                                    "discount_amount": disTotal.value,
                                    "total_amount": subtotal.value + vatTotal.value - disTotal.value,
                                    "subTotal":subtotal.value,
                                    "priceList":priceListController.text,
                                    "discountFixed":discountFixedController.text,
                                    "priceListModel":currentNotifier.getSelectedPriceList,
                                    "productModel":currentNotifier.getSelectedProduct,
                                    "conversionModel":currentNotifier.getSelectedConversion,
                                    "fromConversionItemModel":currentNotifier.getSelectedPriceFromConvItems,
                                  }, editIndex);
                                }else {
                                  currentNotifier.setProductList = {
                                    "item": itemNameController.text,
                                    "quantity": double.parse(qtyController.text),
                                    "unit":unitController.text,
                                    "price": double.parse(rateController.text),
                                    "tax":currentNotifier.getVatPercent,
                                    "tax_amount":vatTotal.value,
                                    "discount": double.parse(discountPercentController.text),
                                    "discount_amount": disTotal.value,
                                    "total_amount": subtotal.value + vatTotal.value - disTotal.value,
                                    "subTotal":subtotal.value,
                                    "priceList":priceListController.text,
                                    "discountFixed":discountFixedController.text,
                                    "priceListModel":currentNotifier.getSelectedPriceList,
                                    "productModel":currentNotifier.getSelectedProduct,
                                    "conversionModel":currentNotifier.getSelectedConversion,
                                    "fromConversionItemModel":currentNotifier.getSelectedPriceFromConvItems,
                                  };
                                }

                                clearVariables();
                                currentNotifier.clearVariables();
                                currentNotifier.calculate();

                                Navigator.pop(context);
                              }, title: "Save & Exit",width: 100.w,height: 60.h,),
                            ),
                            Center(
                              child: CustomButton(onTap: (){
                                if(editIndex !=null){
                                  currentNotifier.updateProductList({
                                    "item": itemNameController.text,
                                    "quantity": double.parse(qtyController.text),
                                    "unit":unitController.text,
                                    "price": double.parse(rateController.text),
                                    "tax":currentNotifier.getVatPercent,
                                    "tax_amount":vatTotal.value,
                                    "discount": double.parse(discountPercentController.text),
                                    "discount_amount": disTotal.value,
                                    "total_amount": subtotal.value + vatTotal.value - disTotal.value,
                                    "subTotal":subtotal.value,
                                    "priceList":priceListController.text,
                                    "discountFixed":discountFixedController.text,
                                    "priceListModel":currentNotifier.getSelectedPriceList,
                                    "productModel":currentNotifier.getSelectedProduct,
                                    "conversionModel":currentNotifier.getSelectedConversion,
                                    "fromConversionItemModel":currentNotifier.getSelectedPriceFromConvItems,
                                  }, editIndex);
                                }else {
                                  currentNotifier.setProductList = {
                                  "item": itemNameController.text,
                                  "quantity": double.parse(qtyController.text).toStringAsFixed(2),
                                  "unit":unitController.text,
                                  "price": double.parse(rateController.text).toStringAsFixed(2),
                                  "tax":currentNotifier.getVatPercent,
                                  "tax_amount":vatTotal.value.toStringAsFixed(2),
                                  "discount": double.parse(discountPercentController.text).toStringAsFixed(2),
                                  "discount_amount": disTotal.value.toStringAsFixed(2),
                                  "total_amount": (subtotal.value + vatTotal.value - disTotal.value).toStringAsFixed(2),
                                  "subTotal":subtotal.value,
                                  "priceList":priceListController.text,
                                  "discountFixed":discountFixedController.text,
                                  "priceListModel":currentNotifier.getSelectedPriceList,
                                  "productModel":currentNotifier.getSelectedProduct,
                                  "conversionModel":currentNotifier.getSelectedConversion,
                                  "fromConversionItemModel":currentNotifier.getSelectedPriceFromConvItems,
                                };
                                }

                                clearVariables();
                                currentNotifier.clearVariables();
                                currentNotifier.calculate();
                                productDetailFun();

                              }, title: "Save & Add",width: 100.w,height: 60.h,),
                            ),
                          ],
                        )
                      ],
                    ),


                  ),
                )
              ],
            ),
          )

      ),
    );
  }
}
