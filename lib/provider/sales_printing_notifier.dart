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
import 'general_notifier.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';


class InvoicePrintingNotifier extends ChangeNotifier{

  bool _isDone = false;

  bool get getIsDone => _isDone;



  Future<List<int>> makeBluetoothInvoice({required BuildContext context}) async {

      List<int> bytes = [];
      final productsNotifier = context.read<CurrentSaleNotifier>();
      final profileNotifier = context.read<ProfileNotifier>();
      CapabilityProfile profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);


      bytes += generator.text( profileNotifier.getProfile?.result?[0].companyName?? "",
          styles: PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size3,
            width: PosTextSize.size3,
          ),
          linesAfter: 1);
      bytes += generator.text(
          productsNotifier.getSelectedCustomer?.name ?? "",
          styles: PosStyles(align: PosAlign.left));
      bytes += generator.text(
          "${productsNotifier.getSelectedCustomer?.address1 ?? ""} ${productsNotifier.getSelectedCustomer?.address2 ?? ""}",
          styles: PosStyles(align: PosAlign.left));
      bytes += generator.text('CRN: +${productsNotifier.getSelectedCustomer?.crnNumber ?? ""}',
          styles: PosStyles(align: PosAlign.left));
      bytes += generator.text('VAT: +${productsNotifier.getSelectedCustomer?.vatNumber ?? ""}',
          styles: PosStyles(align: PosAlign.left));
      bytes += generator.hr();
      bytes += generator.row([
        PosColumn(
            text: 'Invoice',
            width: 3,
            styles: PosStyles(align: PosAlign.left, bold: true)),
        PosColumn(
            text: 'Date',
            width: 3,
            styles: PosStyles(align: PosAlign.center, bold: true)),
        PosColumn(
            text: 'Time',
            width: 3,
            styles: PosStyles(align: PosAlign.center, bold: true)),
        PosColumn(
            text: 'Payment',
            width: 3,
            styles: PosStyles(align: PosAlign.right, bold: true)),
      ]);
      generator.feed(2);
      bytes += generator.row([
        PosColumn(text:  productsNotifier.getDisplayInvoiceID ?? "",
            width: 3, styles: const PosStyles(
          align: PosAlign.left,

        )),
        PosColumn(
            text: dateFormatter.format(productsNotifier.getDate??DateTime(0000)),
            width: 3,
            styles: const PosStyles(
              align: PosAlign.center,
            )),
        PosColumn(
            text: timeFormatter.format(productsNotifier.getDate ?? DateTime(0000)),
            width: 3,
            styles: const PosStyles(
              align: PosAlign.center,
            )),
        PosColumn(text:  productsNotifier.getPaymentMethod ?? "CASH",
            width: 3, styles: const PosStyles(align: PosAlign.right)),
      ]);
      bytes += generator.hr();
      bytes += generator.row([
        PosColumn(
            text: 'Item',
            width: 2,
            styles: PosStyles(align: PosAlign.left, bold: true)),
        PosColumn(
            text: 'Qty',
            width: 2,
            styles: PosStyles(align: PosAlign.center, bold: true)),
        PosColumn(
            text: 'Unit/Rate',
            width: 2,
            styles: PosStyles(align: PosAlign.center, bold: true)),
        PosColumn(
            text: 'Disc',
            width: 2,
            styles: PosStyles(align: PosAlign.center, bold: true)),
        PosColumn(
            text: 'Rate',
            width: 2,
            styles: PosStyles(align: PosAlign.center, bold: true)),
        PosColumn(
            text: 'Sub',
            width: 2,
            styles: PosStyles(align: PosAlign.right, bold: true)),
      ]);
      generator.feed(2);

      productsNotifier.getItemList.forEach((data) {
        bytes += generator.row([
          PosColumn(text:  data["item"] ?? "", width: 2, styles: const PosStyles(
            align: PosAlign.left,
          )),
          PosColumn(
              text: (data["quantity"] ?? 0).toStringAsFixed(2),
              width: 2,
              styles: const PosStyles(
                align: PosAlign.center,
              )
             ),

          PosColumn(
              text: data["unit"] ?? "",
              width: 2,
              styles: const PosStyles(
                align: PosAlign.center,
              )),
          PosColumn(text:  (data["discount_amount"] ?? 0).toStringAsFixed(2), width: 2, styles: const PosStyles(align: PosAlign.center)),
          PosColumn(text: (data["price"] ?? 0).toStringAsFixed(2) , width: 2, styles: const PosStyles(align: PosAlign.center)),
          PosColumn(text:   (data["total_amount"] ?? 0).toStringAsFixed(2), width: 2, styles: const PosStyles(align: PosAlign.right)),
        ]);
      });
      bytes += generator.hr();

      bytes += generator.row([
        PosColumn(
            text: ' ',
            width: 6,
            styles: const PosStyles(
              align: PosAlign.left,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            )),
        PosColumn(
            text: "Subtotal (SAR) : ${productsNotifier.getTotalSub?.toStringAsFixed(2)}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
            )),
      ]);
      bytes += generator.row([
        PosColumn(
            text: ' ',
            width: 6,
            styles: const PosStyles(
              align: PosAlign.left,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            )),
        PosColumn(
            text: "Discount (SAR) : ${productsNotifier.getTotalDisc?.toStringAsFixed(2)}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
            )),
      ]);
      bytes += generator.row([
        PosColumn(
            text: ' ',
            width: 6,
            styles: const PosStyles(
              align: PosAlign.left,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            )),
        PosColumn(
            text: "VAT (SAR) : ${productsNotifier.getTotalVat?.toStringAsFixed(2)}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
            )),
      ]);
      bytes += generator.row([
        PosColumn(
            text: ' ',
            width: 6,
            styles: const PosStyles(
              align: PosAlign.left,
              height: PosTextSize.size2,
              width: PosTextSize.size2,
            )),
        PosColumn(
            text: "Net Due (SAR) : ${productsNotifier.getTotalAmount?.toStringAsFixed(2)}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              height: PosTextSize.size1,
              width: PosTextSize.size1,
            )),
      ]);
      bytes += generator.hr(ch: '=', linesAfter: 1);
      String dataQrCode = generateQRCodeString(sellerName: profileNotifier.getProfile?.result?[0].companyNameArabic ?? "",
          vatRegNo:profileNotifier.getProfile?.result?[0].companyVat ?? "",
          timeStamp: DateTime.now().toString(),
          invoiceAmount: (productsNotifier.getTotalAmount ?? 0.00).toStringAsFixed(2),
          invoiceVAT: (productsNotifier.getTotalVat ?? 0.00).toStringAsFixed(2));
      bytes += generator.qrcode(dataQrCode,size: QRSize.Size1);
      bytes += generator.hr(linesAfter: 1);
      bytes += generator.text('Thank you for your business',
          styles: PosStyles(align: PosAlign.center, bold: true));

      bytes += generator.text('POWERED BY KENZ TECHNOLOGY\nwww.kenztechnology.com\n +966 53 903 6749',
          styles: PosStyles(align: PosAlign.center), linesAfter: 1);
      bytes += generator.cut();
      log(bytes.toString());
      return bytes;

  }

  Future<void> printBluetoothInvoice({required BuildContext context}) async {
    await makeBluetoothInvoice(context: context);
    final generalNotifier = context.read<GeneralNotifier>();

    if((generalNotifier.getBluetoothPrinterMacID?.isNotEmpty ?? false) && generalNotifier.getBluetoothPrinterMacID !=null) {



      String? isConnected = await BluetoothThermalPrinter.connectionStatus;

      if (isConnected == "true") {

        List<int> bytes = await makeBluetoothInvoice(context: context);

        await BluetoothThermalPrinter.writeBytes(bytes);

      } else {
        // showAwesomeDialogue(title: "Print Error", content: "Could not print at this moment, please try again after connecting printer", type: DialogType.ERROR);
        Navigator.pushNamed(context, bluetoothPrinterScreen );
        //Hadnle Not Connected Senario
      }
     }else{
       showAwesomeDialogue(title: "Print Warning", content: "Please connect Printer through settings", type: DialogType.ERROR);
       Navigator.pushNamed(context, bluetoothPrinterScreen );

     }
  }

  // Future<void> printInvoice({required BuildContext context}) async {
  //   _isDone = false;
  //   notifyListeners();
  //   final pdf = pw.Document();
  //   final userID = await _cashService.readCache(key: AppStrings.userId);
  //   final font = await PdfGoogleFonts.notoNaskhArabicRegular();
  //   final font2 = await PdfGoogleFonts.notoNaskhArabicSemiBold();
  //   final productsNotifier = context.read<CurrentSaleNotifier>();
  //   final profileNotifier = context.read<ProfileNotifier>();
  //
  //
  //   ///page building
  //   List<pw.TableRow> invoiceList = List.generate(
  //       productsNotifier.getItemList.length,
  //           (index) {
  //         final data = productsNotifier.getItemList[index];
  //         return   pw.TableRow(
  //           children: < pw.Widget>[
  //             pw.Padding(
  //               padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:      pw.SizedBox(
  //                 width: 16 * PdfPageFormat.mm,
  //                 child:     pw.Text(
  //                     data["item"] ?? "",
  //                     style: testStyle(FontSize.s6, font),
  //                     textAlign: pw.TextAlign.center,
  //                     textDirection:
  //                 pw.TextDirection.rtl
  //
  //                 ),
  //               ),
  //             ),
  //
  //
  //             pw.Padding(
  //               padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   pw.Text(
  //                   (data["quantity"] ?? 0).toStringAsFixed(2),
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: pw.TextAlign.center,    textDirection:
  //               pw.TextDirection.rtl
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   pw.Text(
  //                   data["unit"] ?? "",
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: pw.TextAlign.center,    textDirection:
  //               pw.TextDirection.rtl
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   pw.Text(
  //                   ( data["price"]?? 0).toStringAsFixed(2),
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: pw.TextAlign.center,    textDirection:
  //               pw.TextDirection.rtl
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   pw.Text(
  //                   (data["tax_amount"] ?? 0).toStringAsFixed(2) ,
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: pw.TextAlign.center,    textDirection:
  //               pw.TextDirection.rtl
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   pw.Text(
  //                   (data["discount_amount"] ?? 0).toStringAsFixed(2) ,
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: pw.TextAlign.center,    textDirection:
  //               pw.TextDirection.rtl
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //               child:   pw.Text(
  //                   (data["total_amount"] ?? 0).toStringAsFixed(2) ,
  //                   style: testStyle(FontSize.s6, font),
  //                   textAlign: pw.TextAlign.center,    textDirection:
  //               pw.TextDirection.rtl
  //               ),
  //             ),
  //           ],
  //         );
  //
  //       });
  //   // Add a page to the PDF
  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: PdfPageFormat.roll80,
  //       build: (pw.Context context) {
  //         return pw.Center(
  //             child: pw.Column(
  //               children: [
  //
  //                 pw.SizedBox(height: 10),
  //                 pw.Text(
  //                     profileNotifier.getProfile?.result?[0].companyNameArabic ?? "",
  //                     style: testStyle(FontSize.s14,font2,
  //                     )
  //                 ),
  //                 pw.SizedBox(height: 10),
  //                 pw.Align(
  //                   alignment: pw.Alignment.centerLeft,
  //                   child:  pw.Container(
  //                       padding: const pw.EdgeInsets.symmetric(horizontal:AppPadding.p16),
  //                       child: pw.Column(
  //                           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                           mainAxisAlignment: pw.MainAxisAlignment.start,
  //                           children: [
  //                             pw.Text(
  //                                 '${productsNotifier.getSelectedCustomer?.nameArabic}',
  //                                 style: testStyle(FontSize.s8,font2),    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                             pw.Text(
  //                                 '${productsNotifier.getSelectedCustomer?.address1A ?? ""} ${productsNotifier.getSelectedCustomer?.address2A ?? ""}',
  //                                 style: testStyle(FontSize.s8,font2),    textDirection:
  //                             pw.TextDirection.rtl,textAlign: pw.TextAlign.left
  //
  //                             ),
  //                             pw.Text(
  //                                 '${productsNotifier.getSelectedCustomer?.crnNumber ?? ""}',
  //                                 style: testStyle(FontSize.s8,font2),
  //
  //                             ),
  //                             pw.Text('${productsNotifier.getSelectedCustomer?.vatNumber ?? ""}',
  //                                 style: testStyle(FontSize.s8,font2),
  //
  //                             ),
  //                           ]
  //                       )
  //                   ),
  //                 ), pw.SizedBox(height: 20),
  //
  //
  //                 ///top table area
  //                 pw.Container(
  //                   padding: pw.EdgeInsets.symmetric(horizontal:AppPadding.p16),
  //                   child: pw.Table(
  //
  //                     children: <pw.TableRow>[
  //                       pw.TableRow(
  //                         children: < pw.Widget>[
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 'Invoice No',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 'Date',
  //                                 style: testStyle(FontSize.s7,font2 ),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 'PO Number',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 'Type',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       pw.TableRow(
  //                         children: <pw.Widget>[
  //                           pw.Divider(),
  //                           pw. Divider(),
  //                           pw. Divider(),
  //                           pw. Divider(),
  //                         ],
  //                       ),
  //
  //                       pw.TableRow(
  //                         children: < pw.Widget>[
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 productsNotifier.getDisplayInvoiceID ?? "",
  //                                 style: testStyle(FontSize.s6, font),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 '${dateFormatter.format(productsNotifier.getDate!)}\n${timeFormatter.format(productsNotifier.getDate!)}',
  //                                 style: testStyle(FontSize.s6, font),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 productsNotifier.getPoNumber ?? "//..//",
  //                                 style: testStyle(FontSize.s6,font),
  //                                 textAlign: pw.TextAlign.center
  //                             ),
  //                           ),
  //
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 productsNotifier.getPaymentMethod ?? "CASH",
  //                                 style: testStyle(FontSize.s6, font),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 pw.SizedBox(height: 10),
  //                 ///product list area
  //                 pw.Container(
  //                   padding: pw.EdgeInsets.symmetric(horizontal:AppPadding.p16),
  //                   child: pw.Table(
  //                     children: <pw.TableRow>[
  //                       pw.TableRow(
  //                         children: < pw.Widget>[
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child: pw.Text(
  //                                 'Name',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 'QTY',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 'Unit',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 'Rate',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 'VAT',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 'Disc',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                           pw.Padding(
  //                             padding: pw.EdgeInsets.symmetric(horizontal: AppPadding.p2),
  //                             child:   pw.Text(
  //                                 'Sub',
  //                                 style: testStyle(FontSize.s7, font2),
  //                                 textAlign: pw.TextAlign.center,    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       pw.TableRow(
  //                         children: <pw.Widget>[
  //                           pw.Divider(),
  //                           pw. Divider(),
  //                           pw. Divider(),
  //                           pw. Divider(),
  //                           pw. Divider(),
  //                           pw. Divider(),
  //                           pw. Divider(),
  //                         ],
  //                       ),
  //                       ...invoiceList,
  //                     ],
  //                   ),
  //                 ),
  //
  //                 ///sub total area
  //                 pw.Align(
  //                   alignment: pw.Alignment.centerRight,
  //                   child:    pw.Container(
  //                     padding: pw.EdgeInsets.all(AppPadding.p16),
  //                     child: pw.Column(
  //                       crossAxisAlignment: pw.CrossAxisAlignment.end,
  //                       children: [
  //                         // Subtotal
  //                         pw.Row(
  //                           mainAxisSize: pw.MainAxisSize.min,
  //                           children: [
  //                             pw.Text(
  //                                 'Total Product Value',
  //                                 style: testStyle(FontSize.s8, font2),    textDirection:
  //                             pw.TextDirection.rtl
  //                             ),
  //                             pw.Text(
  //                                 ' :${productsNotifier.getTotalSub?.toStringAsFixed(2)} SAR',
  //                                 style: testStyle(FontSize.s8, font2),
  //                             ),
  //                           ]
  //                         ),
  //
  //                         pw.SizedBox(height: 5),
  //                         pw.Row(
  //                             mainAxisSize: pw.MainAxisSize.min,
  //                             children: [
  //                               pw.Text(
  //                                   'Discount',
  //                                   style: testStyle(FontSize.s8, font2),
  //                                   textAlign: pw.TextAlign.center,    textDirection:
  //                               pw.TextDirection.rtl
  //                               ),
  //                               pw.Text(
  //                                 ' :${productsNotifier.getTotalDisc?.toStringAsFixed(2)} SAR',
  //                                 style: testStyle(FontSize.s8, font2),
  //                               ),
  //                             ]
  //                         ),
  //
  //                         pw.SizedBox(height: 5),
  //                         pw.Row(
  //                             mainAxisSize: pw.MainAxisSize.min,
  //                             children: [
  //                               pw.Text(
  //                                   'Vat',
  //                                   style: testStyle(FontSize.s8, font2),
  //                                   textAlign: pw.TextAlign.center,    textDirection:
  //                               pw.TextDirection.rtl
  //                               ),
  //                               pw.Text(
  //                                 ' :${productsNotifier.getTotalVat?.toStringAsFixed(2)} SAR',
  //                                 style: testStyle(FontSize.s8, font2),
  //                               ),
  //                             ]
  //                         ),
  //
  //                         pw.SizedBox(height: 5),
  //                         pw.Row(
  //                             mainAxisSize: pw.MainAxisSize.min,
  //                             children: [
  //                               pw.Text(
  //                                   'Net Due',
  //                                   style: testStyle(FontSize.s8, font2),
  //                                   textAlign: pw.TextAlign.center,    textDirection:
  //                               pw.TextDirection.rtl
  //                               ),
  //                               pw.Text(
  //                                 ' :${productsNotifier.getTotalAmount?.toStringAsFixed(2)} SAR',
  //                                 style: testStyle(FontSize.s8, font2),
  //                               ),
  //                             ]
  //                         ),
  //
  //                         pw.SizedBox(height: 5),
  //
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //
  //                 pw.BarcodeWidget(
  //                     data: generateQRCodeString(sellerName: profileNotifier.getProfile?.result?[0].companyNameArabic ?? "",
  //                         vatRegNo:profileNotifier.getProfile?.result?[0].companyVat ?? "",
  //                         timeStamp: DateTime.now().toString(),
  //                         invoiceAmount: (productsNotifier.getTotalAmount ?? 0.00).toStringAsFixed(2),
  //                         invoiceVAT: (productsNotifier.getTotalVat ?? 0.00).toStringAsFixed(2)),
  //                     barcode: pw.Barcode.qrCode(),
  //                     width: 75,
  //                     height: 75
  //                 ),
  //                 pw.SizedBox(height: 10),
  //
  //                 pw.Text(
  //                     'Thank you for your business',
  //                     style: testStyle(FontSize.s8, font2),
  //                     textAlign: pw.TextAlign.center
  //                 ),
  //                 pw.Text(
  //                     'POWERED BY KENZ TECHNOLOGY\nwww.kenztechnology.com\n +966 53 903 6749',
  //                     style: testStyle(FontSize.s10, font2),
  //                     textAlign: pw.TextAlign.center
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
  // pw.TextStyle testStyle(double size,pw.Font font){
  //   return pw.TextStyle(
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