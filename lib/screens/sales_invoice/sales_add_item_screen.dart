import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../constants/app_routes.dart';
import '../../models/product_model/product_base_price_data_model.dart';
import '../../models/product_model/product_result_model.dart';
import '../../models/product_model/product_unit_conversion_model.dart';
import '../../provider/search_notifier.dart';
import '../widget/appbar_main_widget.dart';
import '../widget/text_field_widget.dart';




class SalesAddScreen extends HookWidget {
  const SalesAddScreen({super.key});

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
    final discountPercentController = useTextEditingController(text: "0.00");
    final discountFixedController = useTextEditingController(text: "0.00");
    final taxPercentController = useTextEditingController(text: "0% VAT");
    ValueNotifier<double> subtotal = useState<double>(0.00);
    ValueNotifier<double> disTotal = useState<double>(0.00);
    ValueNotifier<double> vatTotal = useState<double>(0.00);

    useEffect(() {

      Future.microtask(() {
       searchProduct.initializeProductList(productNotifier.getProductModelData?.result ?? []);
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

    return  Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MainAppBarWidget(
                    isFirstPage: false,
                    title: "Add the product"
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
                                                                        currentNotifier.setProduct = data;
                                                                        itemNameController.text = "${data.name}\n${data.nameArabic}";
                                                                        searchProduct.changeSearchString("");
                                                                        Navigator.pop(context);
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
                            },
                          ),
                          kSizedBox15,
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: priceListController,
                                  hintName: "Select Price List",
                                  isReadOnly: true,
                                  onTap: (){
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
                                                                          ProductBasePriceDataModel? data = currentNotifier.getSelectedProduct?.basePriceData?[index];
                                                                          return GestureDetector(
                                                                            onTap: () {
                                                                              currentNotifier.setPriceList = data!;
                                                                              priceListController.text = data.name ?? "";
                                                                              searchProduct.changeSearchString("");
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
                              ),
                              kSizedW10,

                              Expanded(
                                child: TextFormFieldCustom(
                                  controller: unitController,
                                  hintName: "Select Unit",

                                  isReadOnly: true,
                                  onTap: (){
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
                                                                    "Select the unit",
                                                                    style: getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16),
                                                                  ),
                                                                  kSizedBox30,
                                                                  Expanded(
                                                                    child: ListView.separated(
                                                                        separatorBuilder: (context, index) {
                                                                          return const Divider();
                                                                        },
                                                                        itemCount: currentNotifier.getSelectedProduct?.unitConversionData?.length ?? 0,
                                                                        itemBuilder: (context, index) {
                                                                          ProductUnitConversionDataModel? data = currentNotifier.getSelectedProduct?.unitConversionData?[index];
                                                                          return GestureDetector(
                                                                            onTap: () {
                                                                              currentNotifier.setConversion = data!;
                                                                              data.items?.forEach((element) {
                                                                                if(element.id.toString() == currentNotifier.getSelectedPriceList?.id){
                                                                                 currentNotifier.setPriceFromConversion = element;
                                                                                }
                                                                              });
                                                                              qtyController.text = "1";
                                                                              rateController.text = currentNotifier.getSelectedPriceFromConv?.standardLimitPrice ?? "0.00";
                                                                              unitController.text = data.toUnitName ?? "";
                                                                              subtotal.value = double.parse(rateController.text ?? "0.00");
                                                                              searchProduct.changeSearchString("");
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

                                  hintName: "Quantity",
                                  onChanged: (value){
                                    if(value.isNotEmpty){
                                      double val = double.parse(value);
                                      if(val>0 && rateController.text.isNotEmpty){
                                        subtotal.value = val * double.parse(rateController.text);
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
                                    }else if (double.parse(value) > double.parse(currentNotifier.getSelectedPriceFromConv?.maxLimitPrice ?? "0.00")){
                                      // showAwesomeDialogue(title: "Warning", content: 'Please enter a price below \n ${currentNotifier.getSelectedPriceFromConv?.maxLimitPrice ?? "0.00"}', type: DialogType.WARNING);

                                      return 'Please enter a price below ${currentNotifier.getSelectedPriceFromConv?.maxLimitPrice ?? "0.00"}';
                                    }else if(double.parse(value) < double.parse(currentNotifier.getSelectedPriceFromConv?.lowLimitPrice ?? "0.00")){
                                 // showAwesomeDialogue(title: "Warning", content: 'Please enter a price above \n ${currentNotifier.getSelectedPriceFromConv?.lowLimitPrice ?? "0.00"}', type: DialogType.WARNING);
                                    return 'Please enter a price above \n ${currentNotifier.getSelectedPriceFromConv?.lowLimitPrice ?? "0.00"}';
                                    }
                                    return null;
                                  },
                                  onChanged: (value){
                                    if(value.isNotEmpty){
                                      double val = double.parse(value);
                                      if(val>0 && qtyController.text.isNotEmpty){
                                        subtotal.value = val * double.parse(qtyController.text);
                                      }else{
                                        showAwesomeDialogue(title: "INFO", content: "Rate & Quantity should be larger than zero", type: DialogType.INFO);
                                        qtyController.clear();
                                      }
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
                                onChanged: (value){
                                  discountFixedController.text = "0.00";
                                  RegExp numericRegex = RegExp(r'^[0-9]*\.?[0-9]*$');
                                   print(value.isNotEmpty);
                                   print(value != ".");
                                  if(value.isNotEmpty && value != "." ){
                                    if(numericRegex.hasMatch(value)) {
                                      disTotal.value = subtotal.value * (double.parse(discountPercentController.text) / 100);
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
                                onChanged: (value){
                                  discountPercentController.text = "0.00";
                                  RegExp numericRegex = RegExp(r'^[0-9]*\.?[0-9]*$');

                                  if(value.isNotEmpty && value != "." ){
                                    if(numericRegex.hasMatch(value)) {
                                      disTotal.value = double.parse(value);
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
                                  "subTotal":subtotal.value

                                };
                                clearVariables();
                                currentNotifier.clearVariables();
                                currentNotifier.calculate();

                                Navigator.pop(context);
                              }, title: "Save & Exit",width: 100.w,height: 40.h,),
                            ),
                            Center(
                              child: CustomButton(onTap: (){
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
                                  "subTotal":subtotal.value
                                };
                                clearVariables();
                                currentNotifier.clearVariables();
                                currentNotifier.calculate();

                              }, title: "Save & Add",width: 100.w,height: 40.h,),
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
