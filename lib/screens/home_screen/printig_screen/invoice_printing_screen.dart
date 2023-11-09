import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/app_routes.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as im;
import '../../../constants/color_manger.dart';
import '../../../constants/constants.dart';
import '../../../constants/font_manager.dart';
import '../../../constants/style_manager.dart';
import '../../../core/notifier/profile_notifier/profile_notifier.dart';
import '../../../provider/current_sale_notifier.dart';
import '../../../provider/general_notifier.dart';
import '../../../provider/sales_printing_notifier.dart';
import '../../widget/Circular_progress_indicator_widget.dart';
import '../../widget/appbar_main_widget.dart';

class InvoicePrintingScreen extends HookWidget {
   InvoicePrintingScreen({Key? key}) : super(key: key);





  // Future<void> setConnect(String mac) async {
  //   final String? result = await BluetoothThermalPrinter.connect(mac);
  //   print("state conneected $result");
  //   if (result == "true") {
  //     setState(() {
  //       connected = true;
  //     });
  //   }
  // }
  //
  // Future<List<int>> getTicket(Uint8List theImageThatComesFrom) async {
  //   List<int> bytes = [];
  //   CapabilityProfile profile = await CapabilityProfile.load();
  //   final generator = Generator(PaperSize.mm80, profile);
  //   final im.Image? image = im.decodeImage(theImageThatComesFrom);
  //   bytes += generator.imageRaster(image!,align: PosAlign.center);
  //   bytes += generator.cut();
  //   return bytes;
  // }
  //
  // Future<void> printTicket(Uint8List theimageThatComesfr) async {
  //   String? isConnected = await BluetoothThermalPrinter.connectionStatus;
  //   if (isConnected == "true") {
  //     List<int> bytes = await getTicket(theimageThatComesfr);
  //     final result = await  BluetoothThermalPrinter.writeBytes(bytes);
  //     print("Print $result");
  //   } else {
  //     //Hadnle Not Connected Senario
  //   }
  // }
  //

 final ScreenshotController screenshotController = ScreenshotController();
 final ScreenshotController screenshotController1 = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final productsNotifier = context.read<CurrentSaleNotifier>();
    final profileNotifier = context.read<ProfileNotifier>();
    final generalNotifier = context.read<GeneralNotifier>();
    ValueNotifier<bool> isLoading = useState<bool>(false);
    ValueNotifier<Uint8List?> theImageThatComesFromThePrinter = useState<Uint8List?>(null);
    ValueNotifier<Uint8List?> theImageThatComesFromThePrinterQR = useState<Uint8List?>(null);
    String generateQRCodeString({required String sellerName,required String vatRegNo,required String timeStamp,required String invoiceAmount,required String invoiceVAT}){
      BytesBuilder bytesBuilder = BytesBuilder();
// 1. Seller Name
      bytesBuilder.addByte(1);
      List<int> sellerNameBytes = utf8.encode( sellerName) ;
      bytesBuilder .addByte( sellerNameBytes. length);
      bytesBuilder.add(sellerNameBytes) ;
// 2. VAT Registration
      bytesBuilder.addByte(2);
      List<int> vatRegistrationBytes = utf8.encode(vatRegNo);
      bytesBuilder.addByte(vatRegistrationBytes.length);
      bytesBuilder.add (vatRegistrationBytes);
      // 3. Time stamp
      bytesBuilder.addByte(3);
      List<int> timeStampByte = utf8.encode(timeStamp);
      bytesBuilder.addByte(timeStampByte.length);
      bytesBuilder.add (timeStampByte);
      // 4. Invoice Amount
      bytesBuilder.addByte(4);
      List<int> invoiceAmountByte = utf8.encode(invoiceAmount);
      bytesBuilder.addByte(invoiceAmountByte.length);
      bytesBuilder.add (invoiceAmountByte);
      // 4. Invoice VAT
      bytesBuilder.addByte(5);
      List<int> invoiceVATByte = utf8.encode(invoiceVAT);
      bytesBuilder.addByte(invoiceVATByte.length);
      bytesBuilder.add (invoiceVATByte);

      Uint8List qrCodeAsBytes = bytesBuilder. toBytes() ;
      final Base64Encoder b64Encoder = Base64Encoder ( ) ;
      return b64Encoder.convert(qrCodeAsBytes) ;

    }

    List<Column> invoiceItemColumn = List.generate(
        productsNotifier.getItemList.length, (index) {
          final data = productsNotifier.getItemList[index];
       return  Column(
         children: [
           SizedBox(
             width:188,
             child: Text(
                 (data["item"] ?? "").toString().split("-").first,
                 style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                 textAlign: TextAlign.left
             ),
           ),
           (data["item"] ?? "").toString().split("-").last.isNotEmpty?  SizedBox(
             width:188,
             child: Text(
                 data["itemA"] ?? "",
                 style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                 textAlign: TextAlign.left
             ),
           ):kSizedBox,
           Row(
             children: [
               SizedBox(
                 width:23.33,
                 child: Text(
                     '',
                     style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                     textAlign: TextAlign.center
                 ),
               ),
               SizedBox(
                 width: 33.33,
                 child: Text(
                     (data["quantity"] ?? 0).toStringAsFixed(2),
                     style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s8),
                     textAlign: TextAlign.center
                 ),
               ),
               SizedBox(
                 width: 33.33,
                 child: Text(
                     data["unit"] ?? "",
                     style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s8),

                     textAlign: TextAlign.center
                 ),
               ),
               SizedBox(
                 width: 33.33,
                 child: Text(
                     (data["discount_amount"] ?? 0).toStringAsFixed(2),
                     style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s8),

                     textAlign: TextAlign.center
                 ),
               ),
               SizedBox(
                 width: 33.33,
                 child: Text(
                     (data["price"] ?? 0).toStringAsFixed(2),
                     style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s8),
                     textAlign: TextAlign.center
                 ),
               ),
               SizedBox(
                 width: 33.33,
                 child: Text(
                     (data["total_amount"] ?? 0).toStringAsFixed(2),
                     style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s8),
                     textAlign: TextAlign.center
                 ),
               )

             ],
           ),
           kSizedBox2,
         ],
       );
    });


    return Scaffold(
      appBar:   PreferredSize(
          preferredSize: Size.fromHeight(100.0.h), // here the desired height
          child:   SafeArea(
            child: const MainAppBarWidget(
                isFirstPage: false,
                title:"Printing Preview"
            ),
          ),
      ),
      body: Stack(
        children: [
          Center(
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     kSizedBox20,
                      CustomButton(onTap: () async {
                       isLoading.value = true;
                       await screenshotController.capture(delay: const Duration(seconds: 1)).then((capturedImage) async {
                         await screenshotController1.capture(delay:const Duration(milliseconds: 500) ).then((qrImage) async {
                           theImageThatComesFromThePrinter.value = capturedImage;
                           theImageThatComesFromThePrinterQR.value = qrImage;
                           if(((theImageThatComesFromThePrinter.value?.isNotEmpty ?? false) && theImageThatComesFromThePrinter.value != null) && ((theImageThatComesFromThePrinterQR.value?.isNotEmpty ?? false) && theImageThatComesFromThePrinterQR.value != null)){
                            await  context.read<InvoicePrintingNotifier>().printBluetoothInvoice(context: context,receipt:theImageThatComesFromThePrinter.value!,qrCode: theImageThatComesFromThePrinterQR.value!).then((value) {
                              if(value == "true"){
                                Navigator.pushReplacementNamed(context, homeRoute);
                              }
                            });

                           }else{
                             showAwesomeDialogue(title: "Printing Error", content: "Please Try again later to print", type: DialogType.INFO_REVERSED);
                           }
                           isLoading.value = false;

                         }).catchError((onError) {
                           print(onError);
                           isLoading.value = false;

                         });
                        }).catchError((onError) {
                          print(onError);
                          isLoading.value = false;

                       });

                      }, title: "Print"),

                     kSizedBox20,
                      Column(
                        children: [
                          Center(
                            child: Screenshot(
                              controller: screenshotController,
                              child: Container(
                                color: ColorManager.white,
                                width: 190,
                                child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(child: Text( profileNotifier.getProfile?.result?[0].companyName?? "",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s18),textAlign: TextAlign.center,)),
                                      kSizedBox10,
                                      Center(child: Text( generalNotifier.getTypeOfTransaction == Transaction.salesReturn || generalNotifier.getTypeOfTransaction == Transaction.totalSalesReturn
                                          ? "Sales Return/عائد المبيعات" :"Tax Invoice/فاتورة ضريبية",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s14),textAlign: TextAlign.center,)),
                                      kSizedBox20,
                                      Text( "${profileNotifier.getProfile?.result?[0].companyAddress1 ?? ""}, ${profileNotifier.getProfile?.result?[0].companyAddress2 ?? ""}",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize:FontSize.s9),),
                                      Text( "${profileNotifier.getProfile?.result?[0].companyAddress1Arabic ?? ""}, ${profileNotifier.getProfile?.result?[0].companyAddress2Arabic ?? ""}",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s9),),
                                      Text("VAT: ${profileNotifier.getProfile?.result?[0].companyVat}",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s9),),
                                      Text("CRN: ${profileNotifier.getProfile?.result?[0].companyCrn}",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s9),),
                                      MySeparator(color: ColorManager.black),
                                      Text( productsNotifier.getSelectedCustomer?.name ?? "",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize:FontSize.s9),),
                                      Text( productsNotifier.getSelectedCustomer?.nameArabic ?? "",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize:FontSize.s9),),
                                      Text("${productsNotifier.getSelectedCustomer?.address1 ?? ""}, ${productsNotifier.getSelectedCustomer?.address2 ?? ""}",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s9),),
                                      Text("${productsNotifier.getSelectedCustomer?.address1A ?? ""}, ${productsNotifier.getSelectedCustomer?.address2A ?? ""}",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize:FontSize.s9,)),
                                      Text("VAT: ${productsNotifier.getSelectedCustomer?.crnNumber ?? ""}",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s9),),
                                      Text("CRN: ${productsNotifier.getSelectedCustomer?.vatNumber ?? ""}",style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s9),),
                                      MySeparator(color: ColorManager.black,isDouble: true,),

                                      Container(
                                        // padding: EdgeInsets.symmetric(horizontal:AppPadding.p16),
                                        child: Table(
                                          children: <TableRow>[
                                            TableRow(
                                              children: < Widget>[
                                                Text(
                                                    'فاتورة',
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                    textAlign: TextAlign.center
                                                ),
                                                Text(
                                                    'تاريخ',
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                                                    textAlign: TextAlign.center
                                                ),
                                                Text(
                                                    'وقت',
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                                                    textAlign: TextAlign.center
                                                ),
                                                Text(
                                                    'قسط',
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10,),
                                                    textAlign: TextAlign.center

                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: < Widget>[
                                                Text(
                                                    'Invoice',
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                    textAlign: TextAlign.center
                                                ),
                                                Text(
                                                    'Date',
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                                                    textAlign: TextAlign.center
                                                ),
                                                Text(
                                                    'Time',
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                                                    textAlign: TextAlign.center
                                                ),
                                                Text(
                                                    'Payment',
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10,),
                                                    textAlign: TextAlign.center

                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: <Widget>[
                                                MySeparator(color: ColorManager.black),
                                                MySeparator(color: ColorManager.black),
                                                MySeparator(color: ColorManager.black),
                                                MySeparator(color: ColorManager.black),
                                              ],
                                            ),

                                            TableRow(
                                              children: < Widget>[
                                                Text(
                                                    productsNotifier.getDisplaySeriesID ?? "",
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s8),

                                                    textAlign: TextAlign.center
                                                ),
                                                Text(
                                                    dateFormatter.format(productsNotifier.getDate??DateTime(0000)),
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s8),
                                                    textAlign: TextAlign.center
                                                ),
                                                Text(
                                                    timeFormatter.format(productsNotifier.getDate ?? DateTime(0000)),
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s8),
                                                    textAlign: TextAlign.center
                                                ),
                                                Text(
                                                    productsNotifier.getPaymentMethod ?? "CASH",
                                                    style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s8),
                                                    textAlign: TextAlign.center
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      kSizedBox10,
                                      SizedBox(
                                        // padding: EdgeInsets.symmetric(horizontal:AppPadding.p16),
                                          child: Column(
                                            children: [
                                              Row(

                                                children: [
                                                  SizedBox(
                                                    width:23.33,
                                                    child: Text(
                                                        'غرض',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 33.33,
                                                    child: Text(
                                                        'الكمية',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 33.33,
                                                    child: Text(
                                                        'وحدة',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 33.33,
                                                    child: Text(
                                                        'القرص',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 33.33,
                                                    child: Text(
                                                        'سعر',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 33.33,
                                                    child: Text(
                                                        'الفرعية',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(

                                                children: [
                                                  SizedBox(
                                                    width:23.33,
                                                    child: Text(
                                                        'Item',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 33.33,
                                                    child: Text(
                                                        'QTY',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 33.33,
                                                    child: Text(
                                                        'Unit',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 33.33,
                                                    child: Text(
                                                        'Disc.',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),

                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 33.33,
                                                    child: Text(
                                                        'Rate',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 33.33,
                                                    child: Text(
                                                        'SUB',
                                                        style: getBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                        textAlign: TextAlign.center
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              MySeparator(color: ColorManager.black),
                                            ...invoiceItemColumn,
                                            ],
                                          )
                                      ),
                                      MySeparator(color: ColorManager.black,isDouble: true,),
                                      ///sub total area
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child:    Container(
                                          // padding: EdgeInsets.all(AppPadding.p16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              // Subtotal
                                              Text(
                                                  'Subtotal / المجموع الفرعي (SAR):  ${productsNotifier.getTotalSub?.toStringAsFixed(2)}',
                                                  style: getSemiBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                  textAlign: TextAlign.center
                                              ),
                                              kSizedBox4,

                                              Text(
                                                  'Discount / تخفيض (SAR): ${productsNotifier.getTotalDisc?.toStringAsFixed(2)}',
                                                  style: getSemiBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                  textAlign: TextAlign.center
                                              ),
                                              kSizedBox4,

                                              Text(
                                                  'VAT / ضريبة القيمة المضافة (SAR): ${productsNotifier.getTotalVat?.toStringAsFixed(2)}',
                                                  style: getSemiBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                  textAlign: TextAlign.center
                                              ),
                                            kSizedBox4,
                                           Text(
                                                  'Net Due / صافي نتيجة (SAR): ${productsNotifier.getTotalAmount?.toStringAsFixed(2)}',
                                                  style: getSemiBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                                  textAlign: TextAlign.center
                                              ),
                                              kSizedBox4,
                                          MySeparator(isDouble: true,color: ColorManager.black,),

                                            ],
                                          ),
                                        ),
                                      ),


                                    ]
                                ),

                              ),
                            ),
                          ),
                          Center(
                            child: Screenshot(
                              controller: screenshotController1,
                              child: Container(
                                color: Colors.white,
                                width: 190,
                                child: Column(
                                  children: [
                                 generalNotifier.getTypeOfTransaction == Transaction.sales ||  generalNotifier.getTypeOfTransaction == Transaction.totalSales ?   QrImageView(
                                      data: generateQRCodeString(sellerName: profileNotifier.getProfile?.result?[0].companyNameArabic ?? "",
                                          vatRegNo:profileNotifier.getProfile?.result?[0].companyVat ?? "",
                                          timeStamp: DateTime.now().toString(),
                                          invoiceAmount: (productsNotifier.getTotalAmount ?? 0.00).toStringAsFixed(2),
                                          invoiceVAT: (productsNotifier.getTotalVat ?? 0.00).toStringAsFixed(2)),
                                      size: 100.0,
                                    ):kSizedBox,
                                    MySeparator(color: ColorManager.black,),

                                    Text(
                                        'Thank you for your business',
                                        style: getSemiBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                        textAlign: TextAlign.center
                                    ),
                                    Text(
                                        "POWERED BY KENZ TECHNOLOGY\nwww.kenztechnology.com\n +966 53 903 6749",
                                        style: getSemiBoldInvoiceStyle(color: ColorManager.black,fontSize: FontSize.s10),
                                        textAlign: TextAlign.center
                                    ),
                                    kSizedBox40
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                   kSizedBox20,
                    ],
                  ),
                ],
              )),
          isLoading.value ?  Positioned.fill(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    color: const Color(0x66ffffff),
                    child: const CircularProgressIndicatorWidget(),
                  ))):kSizedBox
        ],
      ),
    );
  }
}