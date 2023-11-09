import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kenz_app/constants/app_routes.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/core/notifier/profile_notifier/profile_notifier.dart';
import 'package:kenz_app/provider/current_sale_notifier.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';

import '../constants/font_manager.dart';
import '../constants/string_manager.dart';
import '../constants/values_manger.dart';
import '../core/service/shared_preferance_service.dart';
import '../screens/home_screen/settings/bluetooth_printer_setup_screen.dart';
import 'general_notifier.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:image/image.dart' as im;


class InvoicePrintingNotifier extends ChangeNotifier{

  bool _isDone = false;

  bool get getIsDone => _isDone;

  Future<List<int>> makeBluetoothInvoice({required BuildContext context,required Uint8List receipt,required Uint8List qrCode}) async {

      List<int> bytes = [];
      final productsNotifier = context.read<CurrentSaleNotifier>();
      final profileNotifier = context.read<ProfileNotifier>();

      CapabilityProfile profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);
///image
      final im.Image? image = im.decodeImage(receipt);
      final im.Image? image2 = im.decodeImage(qrCode);
      bytes += generator.imageRaster(image!,align: PosAlign.center);
      bytes += generator.imageRaster(image2!,align: PosAlign.center);

      return bytes;

  }

  Future<String?> printBluetoothInvoice({required BuildContext context,required Uint8List receipt,required Uint8List qrCode}) async {

    final generalNotifier = context.read<GeneralNotifier>();

    if((generalNotifier.getBluetoothPrinterMacID?.isNotEmpty ?? false) && generalNotifier.getBluetoothPrinterMacID !=null) {



      String? isConnected = await BluetoothThermalPrinter.connectionStatus;

      if (isConnected == "true") {
        List<int> bytes = await makeBluetoothInvoice(context: context,receipt: receipt,qrCode: qrCode);
      final p =  await BluetoothThermalPrinter.writeBytes(bytes);
      print("ssss $p");
      return p;
      } else {
        // showAwesomeDialogue(title: "Print Error", content: "Could not print at this moment, please try again after connecting printer", type: DialogType.ERROR);
        // Navigator.pushNamed(context, bluetoothPrinterScreen );
        Navigator.push(context, MaterialPageRoute(builder: (context) => BluetoothPrinterScreen(isAccessInside: true,)));
        //Hadnle Not Connected Senario
      }
     }else{
       showAwesomeDialogue(title: "Print Warning", content: "Please connect Printer through settings" , type: DialogType.INFO);
       Navigator.push(context, MaterialPageRoute(builder: (context) => BluetoothPrinterScreen(isAccessInside: true,)));
    }
    return null;
  }

  // Future<void> printInvoice({required BuildContext context}) async {
  //   _isDone = false;
  //   notifyListeners();
  //   final pdf = Document();
  //   final userID = await _cashService.readCache(key: AppStrings.userId);
  //   final font = await PdfGoogleFonts.notoNaskhArabicRegular();
  //   final font2 = await PdfGoogleFonts.notoNaskhArabicSemiBold();
  //   final productsNotifier = context.read<CurrentSaleNotifier>();
  //   final profileNotifier = context.read<ProfileNotifier>();
  //
  //
  //   ///page building
  //   List<TableRow> invoiceList = List.generate(
  //       productsNotifier.getItemList.length,
  //           (index) {
  //         final data = productsNotifier.getItemList[index];
  //         return   TableRow(
  //           children: < Widget>[
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:      SizedBox(
  //                 width: 16 * PdfPageFormat.mm,
  //                 child:     Text(
  //                     data["item"] ?? "",
  //                     style: testStyle(FontSize.s6, font),
  //                     textAlign: TextAlign.center,
  //                     textDirection:
  //                 TextDirection.rtl
  //
  //                 ),
  //               ),
  //             ),
  //
  //
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   Text(
  //                   (data["quantity"] ?? 0).toStringAsFixed(2),
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: TextAlign.center,    textDirection:
  //               TextDirection.rtl
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   Text(
  //                   data["unit"] ?? "",
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: TextAlign.center,    textDirection:
  //               TextDirection.rtl
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   Text(
  //                   ( data["price"]?? 0).toStringAsFixed(2),
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: TextAlign.center,    textDirection:
  //               TextDirection.rtl
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   Text(
  //                   (data["tax_amount"] ?? 0).toStringAsFixed(2) ,
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: TextAlign.center,    textDirection:
  //               TextDirection.rtl
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   Text(
  //                   (data["discount_amount"] ?? 0).toStringAsFixed(2) ,
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: TextAlign.center,    textDirection:
  //               TextDirection.rtl
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   Text(
  //                   (data["total_amount"] ?? 0).toStringAsFixed(2) ,
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: TextAlign.center,    textDirection:
  //               TextDirection.rtl
  //               ),
  //             ),
  //           ],
  //         );
  //
  //       });
  //   // Add a page to the PDF
  //   pdf.addPage(
  //     Page(
  //       pageFormat: PdfPageFormat.roll80,
  //       build: (Context context) {
  //         return Center(
  //             child: Column(
  //               children: [
  //
  //                 SizedBox(height: 10),
  //                 Text(
  //                     profileNotifier.getProfile?.result?[0].companyNameArabic ?? "",
  //                     style: testStyle(FontSize.s14,font2,
  //                     )
  //                 ),
  //                 SizedBox(height: 10),
  //                 Align(
  //                   alignment: Alignment.centerLeft,
  //                   child:  Container(
  //                       padding: const EdgeInsets.symmetric(horizontal:AppPadding.p16),
  //                       child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                                 '${productsNotifier.getSelectedCustomer?.nameArabic}',
  //                                 style: testStyle(FontSize.s8,font2),    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                             Text(
  //                                 '${productsNotifier.getSelectedCustomer?.address1A ?? ""} ${productsNotifier.getSelectedCustomer?.address2A ?? ""}',
  //                                 style: testStyle(FontSize.s8,font2),    textDirection:
  //                             TextDirection.rtl,textAlign: TextAlign.left
  //
  //                             ),
  //                             Text(
  //                                 '${productsNotifier.getSelectedCustomer?.crnNumber ?? ""}',
  //                                 style: testStyle(FontSize.s8,font2),
  //
  //                             ),
  //                             Text('${productsNotifier.getSelectedCustomer?.vatNumber ?? ""}',
  //                                 style: testStyle(FontSize.s8,font2),
  //
  //                             ),
  //                           ]
  //                       )
  //                   ),
  //                 ), SizedBox(height: 20),
  //
  //
  //                 ///top table area
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal:AppPadding.p16),
  //                   child: Table(
  //
  //                     children: <TableRow>[
  //                       TableRow(
  //                         children: < Widget>[
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 'Invoice No',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 'Date',
  //                                 style: testStyle(FontSize.s7,font2 ),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 'PO Number',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 'Type',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       TableRow(
  //                         children: <Widget>[
  //                          const MySeparator(color: ColorManager.black),
  //                           const MySeparator(color: ColorManager.black),
  //                           const MySeparator(color: ColorManager.black),
  //                           const MySeparator(color: ColorManager.black),
  //                         ],
  //                       ),
  //
  //                       TableRow(
  //                         children: < Widget>[
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 productsNotifier.getDisplayInvoiceID ?? "",
  //                                 style: testStyle(FontSize.s6, font),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 '${dateFormatter.format(productsNotifier.getDate!)}\n${timeFormatter.format(productsNotifier.getDate!)}',
  //                                 style: testStyle(FontSize.s6, font),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 productsNotifier.getPoNumber ?? "//..//",
  //                                 style: testStyle(FontSize.s6,font),
  //                                 textAlign: TextAlign.center
  //                             ),
  //                           ),
  //
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 productsNotifier.getPaymentMethod ?? "CASH",
  //                                 style: testStyle(FontSize.s6, font),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height: 10),
  //                 ///product list area
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal:AppPadding.p16),
  //                   child: Table(
  //                     children: <TableRow>[
  //                       TableRow(
  //                         children: < Widget>[
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child: Text(
  //                                 'Name',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 'QTY',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 'Unit',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 'Rate',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 'VAT',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 'Disc',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   Text(
  //                                 'Sub',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: TextAlign.center,    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       TableRow(
  //                         children: <Widget>[
  //                          const MySeparator(color: ColorManager.black),
  //                           const MySeparator(color: ColorManager.black),
  //                           const MySeparator(color: ColorManager.black),
  //                           const MySeparator(color: ColorManager.black),
  //                           const MySeparator(color: ColorManager.black),
  //                           const MySeparator(color: ColorManager.black),
  //                           const MySeparator(color: ColorManager.black),
  //                         ],
  //                       ),
  //                       ...invoiceList,
  //                     ],
  //                   ),
  //                 ),
  //
  //                 ///sub total area
  //                 Align(
  //                   alignment: Alignment.centerRight,
  //                   child:    Container(
  //                     padding: EdgeInsets.all(AppPadding.p16),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       children: [
  //                         // Subtotal
  //                         Row(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             Text(
  //                                 'Total Product Value',
  //                                 style: testStyle(FontSize.s8, font2),    textDirection:
  //                             TextDirection.rtl
  //                             ),
  //                             Text(
  //                                 ' :${productsNotifier.getTotalSub?.toStringAsFixed(2)} SAR',
  //                                 style: testStyle(FontSize.s8, font2),
  //                             ),
  //                           ]
  //                         ),
  //
  //                         SizedBox(height: 5),
  //                         Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Text(
  //                                   'Discount',
  //                                   style: testStyle(FontSize.s8, font2),
  //                                   textAlign: TextAlign.center,    textDirection:
  //                               TextDirection.rtl
  //                               ),
  //                               Text(
  //                                 ' :${productsNotifier.getTotalDisc?.toStringAsFixed(2)} SAR',
  //                                 style: testStyle(FontSize.s8, font2),
  //                               ),
  //                             ]
  //                         ),
  //
  //                         SizedBox(height: 5),
  //                         Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Text(
  //                                   'Vat',
  //                                   style: testStyle(FontSize.s8, font2),
  //                                   textAlign: TextAlign.center,    textDirection:
  //                               TextDirection.rtl
  //                               ),
  //                               Text(
  //                                 ' :${productsNotifier.getTotalVat?.toStringAsFixed(2)} SAR',
  //                                 style: testStyle(FontSize.s8, font2),
  //                               ),
  //                             ]
  //                         ),
  //
  //                         SizedBox(height: 5),
  //                         Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Text(
  //                                   'Net Due',
  //                                   style: testStyle(FontSize.s8, font2),
  //                                   textAlign: TextAlign.center,    textDirection:
  //                               TextDirection.rtl
  //                               ),
  //                               Text(
  //                                 ' :${productsNotifier.getTotalAmount?.toStringAsFixed(2)} SAR',
  //                                 style: testStyle(FontSize.s8, font2),
  //                               ),
  //                             ]
  //                         ),
  //
  //                         SizedBox(height: 5),
  //
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //
  //                 BarcodeWidget(
  //                     data: generateQRCodeString(sellerName: profileNotifier.getProfile?.result?[0].companyNameArabic ?? "",
  //                         vatRegNo:profileNotifier.getProfile?.result?[0].companyVat ?? "",
  //                         timeStamp: DateTime.now().toString(),
  //                         invoiceAmount: (productsNotifier.getTotalAmount ?? 0.00).toStringAsFixed(2),
  //                         invoiceVAT: (productsNotifier.getTotalVat ?? 0.00).toStringAsFixed(2)),
  //                     barcode: Barcode.qrCode(),
  //                     width: 75,
  //                     height: 75
  //                 ),
  //                 SizedBox(height: 10),
  //
  //                 Text(
  //                     'Thank you for your business',
  //                     style: testStyle(FontSize.s8, font2),
  //                     textAlign: TextAlign.center
  //                 ),
  //                 Text(
  //                     'POWERED BY KENZ TECHNOLOGY\nwww.kenztechnology.com\n +966 53 903 6749',
  //                     style: testStyle(FontSize.s10, font2),
  //                     textAlign: TextAlign.center
  //                 ),
  //
  //               ],
  //             )
  //         );
  //       },
  //     ),
  //   );
  //
  // }
  // TextStyle testStyle(double size,Font font){
  //   return TextStyle(
  //       fontSize: size,
  //       font: font
  //   );
  // }

  String generateQRCodeString({required String sellerName,required String vatRegNo,required String timeStamp,required String invoiceAmount,required String invoiceVAT}){
    BytesBuilder bytesBuilder = BytesBuilder();
// 1. Seller Name
    bytesBuilder.addByte(1);
    List<int> sellerNameBytes = utf8 .encode( sellerName) ;
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
}


// bytes += generator.text( profileNotifier.getProfile?.result?[0].companyName?? "",
// styles: const PosStyles(
// align: PosAlign.center,
// height: PosTextSize.size3,
// width: PosTextSize.size3,
// bold: true
// ),
// linesAfter: 1);
// bytes += generator.text(  generalNotifier.getTypeOfTransaction == Transaction.salesReturn ? "Sales Return" :"Tax Invoice",
// styles: const PosStyles(
// align: PosAlign.center,
// height: PosTextSize.size2,
// width: PosTextSize.size2,
// bold: true
// ),
// linesAfter: 1);
// bytes += generator.text(
// "${profileNotifier.getProfile?.result?[0].companyAddress1 ?? ""}\n${profileNotifier.getProfile?.result?[0].companyAddress2 ?? ""}",
// styles: PosStyles(align: PosAlign.left));
// bytes += generator.text('VAT:${profileNotifier.getProfile?.result?[0].companyVat}',
// styles: PosStyles(align: PosAlign.left, bold: true));
// bytes += generator.text('CRN:${profileNotifier.getProfile?.result?[0].companyCrn}',
// styles: PosStyles(align: PosAlign.left, bold: true));
// bytes += generator.hr();
// bytes += generator.text(
// productsNotifier.getSelectedCustomer?.name ?? "",
// styles: PosStyles(align: PosAlign.left));
// bytes += generator.text(
// "${productsNotifier.getSelectedCustomer?.address1 ?? ""} ${productsNotifier.getSelectedCustomer?.address2 ?? ""}",
// styles: PosStyles(align: PosAlign.left));
// bytes += generator.text('CRN: +${productsNotifier.getSelectedCustomer?.crnNumber ?? ""}',
// styles: PosStyles(align: PosAlign.left));
// bytes += generator.text('VAT: +${productsNotifier.getSelectedCustomer?.vatNumber ?? ""}',
// styles: PosStyles(align: PosAlign.left));
// bytes += generator.hr();
// bytes += generator.row([
// PosColumn(
// text: 'Invoice',
// width: 3,
// styles: PosStyles(align: PosAlign.left, bold: true,)),
// PosColumn(
// text: 'Date',
// width: 3,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: 'Time',
// width: 3,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: 'Payment',
// width: 3,
// styles: PosStyles(align: PosAlign.right, bold: true)),
// ]);
// bytes += generator.row([
// PosColumn(
// text: ' ',
// width: 3,
// styles: PosStyles(align: PosAlign.left, bold: true,)),
// PosColumn(
// text: ' ',
// width: 3,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: ' ',
// width: 3,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: ' ',
// width: 3,
// styles: PosStyles(align: PosAlign.right, bold: true)),
// ]);
// bytes += generator.row([
// PosColumn(text:  productsNotifier.getDisplaySeriesID ?? "",
// width: 3, styles: const PosStyles(
// align: PosAlign.left,
//
// )),
// PosColumn(
// text: dateFormatter.format(productsNotifier.getDate??DateTime(0000)),
// width: 3,
// styles: const PosStyles(
// align: PosAlign.center,
// )),
// PosColumn(
// text: timeFormatter.format(productsNotifier.getDate ?? DateTime(0000)),
// width: 3,
// styles: const PosStyles(
// align: PosAlign.center,
// )),
// PosColumn(text:  productsNotifier.getPaymentMethod ?? "CASH",
// width: 3, styles: const PosStyles(align: PosAlign.right)),
// ]);
// bytes += generator.hr();
// bytes += generator.row([
// PosColumn(
// text: 'Item',
// width: 2,
// styles: PosStyles(align: PosAlign.left, bold: true)),
// PosColumn(
// text: 'Qty',
// width: 2,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: 'Unit',
// width: 2,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: 'Disc',
// width: 2,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: 'Rate',
// width: 2,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: 'Sub',
// width: 2,
// styles: PosStyles(align: PosAlign.right, bold: true)),
// ]);
// bytes += generator.row([
// PosColumn(
// text: ' ',
// width: 2,
// styles: PosStyles(align: PosAlign.left, bold: true)),
// PosColumn(
// text: ' ',
// width: 2,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: ' ',
// width: 2,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: ' ',
// width: 2,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: ' ',
// width: 2,
// styles: PosStyles(align: PosAlign.center, bold: true)),
// PosColumn(
// text: ' ',
// width: 2,
// styles: PosStyles(align: PosAlign.right, bold: true)),
// ]);
// productsNotifier.getItemList.forEach((data) {
// bytes += generator.row([
// PosColumn(text:  data["item"] ?? "", width: 2, styles: const PosStyles(
// align: PosAlign.left,
// )),
// PosColumn(
// text: (data["quantity"] ?? 0).toStringAsFixed(2),
// width: 2,
// styles: const PosStyles(
// align: PosAlign.center,
// )
// ),
//
// PosColumn(
// text: data["unit"] ?? "",
// width: 2,
// styles: const PosStyles(
// align: PosAlign.center,
// )),
// PosColumn(text:  (data["discount_amount"] ?? 0).toStringAsFixed(2), width: 2, styles: const PosStyles(align: PosAlign.center)),
// PosColumn(text: (data["price"] ?? 0).toStringAsFixed(2) , width: 2, styles: const PosStyles(align: PosAlign.center)),
// PosColumn(text:   (data["total_amount"] ?? 0).toStringAsFixed(2), width: 2, styles: const PosStyles(align: PosAlign.right)),
// ]);
// });
// bytes += generator.hr();
//
// bytes += generator.row([
// PosColumn(
// text: ' ',
// width: 6,
// styles: const PosStyles(
// align: PosAlign.left,
// height: PosTextSize.size2,
// width: PosTextSize.size2,
// )),
// PosColumn(
// text: "Subtotal (SAR) : ${productsNotifier.getTotalSub?.toStringAsFixed(2)}",
// width: 6,
// styles: PosStyles(
// align: PosAlign.right,
// height: PosTextSize.size1,
// width: PosTextSize.size1,
// )),
// ]);
// bytes += generator.row([
// PosColumn(
// text: ' ',
// width: 6,
// styles: const PosStyles(
// align: PosAlign.left,
// height: PosTextSize.size2,
// width: PosTextSize.size2,
// )),
// PosColumn(
// text: "Discount (SAR) : ${productsNotifier.getTotalDisc?.toStringAsFixed(2)}",
// width: 6,
// styles: PosStyles(
// align: PosAlign.right,
// height: PosTextSize.size1,
// width: PosTextSize.size1,
// )),
// ]);
// bytes += generator.row([
// PosColumn(
// text: ' ',
// width: 6,
// styles: const PosStyles(
// align: PosAlign.left,
// height: PosTextSize.size2,
// width: PosTextSize.size2,
// )),
// PosColumn(
// text: "VAT (SAR) : ${productsNotifier.getTotalVat?.toStringAsFixed(2)}",
// width: 6,
// styles: PosStyles(
// align: PosAlign.right,
// height: PosTextSize.size1,
// width: PosTextSize.size1,
// )),
// ]);
// bytes += generator.row([
// PosColumn(
// text: ' ',
// width: 6,
// styles: const PosStyles(
// align: PosAlign.left,
// height: PosTextSize.size2,
// width: PosTextSize.size2,
// )),
// PosColumn(
// text: "Net Due (SAR) : ${productsNotifier.getTotalAmount?.toStringAsFixed(2)}",
// width: 6,
// styles: PosStyles(
// align: PosAlign.right,
// height: PosTextSize.size1,
// width: PosTextSize.size1,
// )),
// ]);
// bytes += generator.hr(ch: '=', linesAfter: 1);