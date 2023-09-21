
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/home_screen/settings/widget/bluetooth_widgets.dart';
import 'package:kenz_app/screens/widget/appbar_main_widget.dart';
import 'package:kenz_app/screens/widget/rounded_button_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_manger.dart';
import '../../../constants/constants.dart';
import '../../../constants/font_manager.dart';

final snackBarKeyA = GlobalKey<ScaffoldMessengerState>();
final snackBarKeyB = GlobalKey<ScaffoldMessengerState>();
final snackBarKeyC = GlobalKey<ScaffoldMessengerState>();
final Map<DeviceIdentifier, ValueNotifier<bool>> isConnectingOrDisconnecting = {};
class BluetoothAdapterStateObserver extends NavigatorObserver {
  StreamSubscription<BluetoothAdapterState>? _btStateSubscription;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == '/deviceScreen') {
      // Start listening to Bluetooth state changes when a new route is pushed
      _btStateSubscription ??= FlutterBluePlus.adapterState.listen((state) {
        if (state != BluetoothAdapterState.on) {
          // Pop the current route if Bluetooth is off
          navigator?.pop();
        }
      });
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    // Cancel the subscription when the route is popped
    _btStateSubscription?.cancel();
    _btStateSubscription = null;
  }
}

class BluetoothPrinterScreen extends StatelessWidget {
  const BluetoothPrinterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<BluetoothAdapterState>(
          stream: FlutterBluePlus.adapterState,
          initialData: BluetoothAdapterState.unknown,
          builder: (c, snapshot) {
            final adapterState = snapshot.data;
            if (adapterState == BluetoothAdapterState.on) {
              return const FindDevicesScreen();
            } else {
              FlutterBluePlus.stopScan();
              return BluetoothOffScreen(adapterState: adapterState);
            }
          }),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.adapterState}) : super(key: key);

  final BluetoothAdapterState? adapterState;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: snackBarKeyA,
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.bluetooth_disabled,
                size: 200.0,
                color: Colors.white54,
              ),
              Text(
                'Bluetooth Adapter is ${adapterState != null ? adapterState.toString().split(".").last : 'not available'}.',
                style: Theme.of(context).primaryTextTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              if (Platform.isAndroid)
                ElevatedButton(
                  child: const Text('TURN ON'),
                  onPressed: () async {
                    try {
                      if (Platform.isAndroid) {
                        await FlutterBluePlus.turnOn();
                      }
                    } catch (e) {
                      final snackBar = snackBarFail(prettyException("Error Turning On:", e));
                      snackBarKeyA.currentState?.removeCurrentSnackBar();
                      snackBarKeyA.currentState?.showSnackBar(snackBar);
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatefulWidget {
  const FindDevicesScreen({Key? key}) : super(key: key);

  @override
  State<FindDevicesScreen> createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreen> {
  bool connected = false;
  String name = "";
  @override
  Widget build(BuildContext context) {


    Future<void> setConnect(String mac) async {
      final String? result = await BluetoothThermalPrinter.connect(mac);
      print("state conneected $result");
      if (result == "true") {
        setState(() {
          connected = true;
        });
      }
    }

    Future<List<int>?> getTicket() async {
      try{
        List<int> bytes = [];
        CapabilityProfile profile = await CapabilityProfile.load();
        final generator = Generator(PaperSize.mm80, profile);

        bytes += generator.text("Demo Shop",
            styles: PosStyles(
              align: PosAlign.center,
              height: PosTextSize.size3,
              width: PosTextSize.size3,
            ),
            linesAfter: 1);

        bytes += generator.text(
            "18th Main Road, 2nd Phase, J. P. Nagar, Bengaluru, Karnataka 560078",
            styles: PosStyles(align: PosAlign.center));
        bytes += generator.text('Tel: +919591708470',
            styles: PosStyles(align: PosAlign.center));

        const utf8Encoder = Utf8Encoder();
        final encodedStr = utf8Encoder.convert("فعاليبت يقعلارىسير يبسعىرسهيعب");
        bytes += generator.textEncoded(Uint8List.fromList([
          ...[ 0x1C, 0x43, 0xFF],
          ...encodedStr
        ]));
        bytes += generator.hr();
        bytes += generator.row([
          PosColumn(
              text: 'Invoice',
              width: 2,
              styles: PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(
              text: 'Date',
              width: 3,
              styles: PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(
              text: 'PO Number',
              width: 4,
              styles: PosStyles(align: PosAlign.center, bold: true)),
          PosColumn(
              text: 'Payment',
              width: 3,
              styles: PosStyles(align: PosAlign.center, bold: true)),
        ]);
        bytes += generator.row([
          PosColumn(text: "INV 0001", width: 2, styles: PosStyles(
            align: PosAlign.center,
          )),
          PosColumn(
              text: "10-09-23",
              width: 3,
              styles: PosStyles(
                align: PosAlign.center,
              )),
          PosColumn(
              text: "po123355",
              width: 4,
              styles: PosStyles(
                align: PosAlign.center,
              )),
          PosColumn(text: "CASH", width: 3, styles: PosStyles(align: PosAlign.center)),
        ]);
        bytes += generator.hr();
        bytes += generator.row([
          PosColumn(
              text: 'No',
              width: 1,
              styles: PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(
              text: 'Item',
              width: 5,
              styles: PosStyles(align: PosAlign.left, bold: true)),
          PosColumn(
              text: 'Price',
              width: 2,
              styles: PosStyles(align: PosAlign.center, bold: true)),
          PosColumn(
              text: 'Qty',
              width: 2,
              styles: PosStyles(align: PosAlign.center, bold: true)),

          PosColumn(
              text: 'Total',
              width: 2,
              styles: PosStyles(align: PosAlign.right, bold: true)),
        ]);

        bytes += generator.row([
          PosColumn(text: "1", width: 1),
          PosColumn(
              text: "Tea",
              width: 5,
              styles: PosStyles(
                align: PosAlign.left,
              )),
          PosColumn(
              text: "10",
              width: 2,
              styles: PosStyles(
                align: PosAlign.center,
              )),
          PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
          PosColumn(text: "10", width: 2, styles: PosStyles(align: PosAlign.right)),
        ]);

        bytes += generator.row([
          PosColumn(text: "2", width: 1),
          PosColumn(
              text: "Sada Dosa",
              width: 5,
              styles: PosStyles(
                align: PosAlign.left,
              )),
          PosColumn(
              text: "30",
              width: 2,
              styles: PosStyles(
                align: PosAlign.center,
              )),
          PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),

          PosColumn(text: "30", width: 2, styles: PosStyles(align: PosAlign.right)),
        ]);

        bytes += generator.row([
          PosColumn(text: "3", width: 1),
          PosColumn(
              text: "Masala Dosa",
              width: 5,
              styles: PosStyles(
                align: PosAlign.left,
              )),
          PosColumn(
              text: "50",
              width: 2,
              styles: PosStyles(
                align: PosAlign.center,
              )),
          PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
          PosColumn(text: "50", width: 2, styles: PosStyles(align: PosAlign.right)),
        ]);

        bytes += generator.row([
          PosColumn(text: "4", width: 1),
          PosColumn(
              text: "Rova Dosa",
              width: 5,
              styles: PosStyles(
                align: PosAlign.left,
              )),
          PosColumn(
              text: "70",
              width: 2,
              styles: PosStyles(
                align: PosAlign.center,
              )),
          PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),

          PosColumn(text: "70", width: 2, styles: PosStyles(align: PosAlign.right)),
        ]);

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
              text: "Subtotal (SAR) : 120",
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
              text: "Discount (SAR) : 10",
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
              text: "VAT (SAR) : 5",
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
              text: "Net Due (SAR) : 135",
              width: 6,
              styles: PosStyles(
                align: PosAlign.right,
                height: PosTextSize.size1,
                width: PosTextSize.size1,
              )),
        ]);
        bytes += generator.hr(ch: '=', linesAfter: 2);


        bytes += generator.feed(2);

        bytes += generator.text('Thank you for your business',
            styles: PosStyles(align: PosAlign.center, bold: true));

        bytes += generator.text('POWERED BY KENZ TECHNOLOGY\nwww.kenztechnology.com\n +966 53 903 6749',
            styles: PosStyles(align: PosAlign.center), linesAfter: 1);
        bytes += generator.cut();
        return bytes;
      }catch(e){
      }
    return null;
    }

    Future<String?> printTicket() async {
      String? isConnected = await BluetoothThermalPrinter.connectionStatus;

      if (isConnected == "true") {
        try{
          List<int>? bytes = await getTicket();
         await BluetoothThermalPrinter.writeBytes(bytes!);
        }catch(e){
        }
        return "OK";
      } else {
        showAwesomeDialogue(title: "Print Error", content: "Please unpair and you device and restart bluetooth", type: DialogType.INFO);
      }
      return null;
    }
    return ScaffoldMessenger(
      key: snackBarKeyB,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:  Size(double.infinity, 150.h),
          child: const SafeArea(child: MainAppBarWidget(isFirstPage: false,title: "Find Devices")),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {}); // force refresh of connectedSystemDevices
            if (FlutterBluePlus.isScanningNow == false) {
              FlutterBluePlus.startScan(timeout: const Duration(seconds: 15), androidUsesFineLocation: false);
            }
            return Future.delayed(Duration(milliseconds: 500)); // show refresh icon breifly
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

               // connected ? Container(
               //    margin: EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p12),
               //    padding: EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p12),
               //    decoration: BoxDecoration(
               //      color: ColorManager.filledColor2,
               //      borderRadius: BorderRadius.circular(12),
               //
               //    ),
               //    child: Row(
               //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
               //      children: [
               //        Text(name,style: getBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s16),),
               //        Text("Connected",style: getBoldStyle(color: ColorManager.green,fontSize: FontSize.s16),),
               //      ],
               //    ),
               //  ):kSizedBox,
                            StreamBuilder<List<BluetoothDevice>>(
                              stream: Stream.fromFuture(FlutterBluePlus.connectedSystemDevices),
                              initialData: const [],
                              builder: (c, snapshot) => Column(
                                children: (snapshot.data ?? [])
                                    .map((d) => ListTile(
                                  title: Text(d.localName,style: getBoldStyle(color: Colors.black),),
                                  subtitle: Text(d.remoteId.toString(),style: getSemiBoldStyle(color: Colors.black),),
                                  trailing: StreamBuilder<BluetoothConnectionState>(
                                    stream: d.connectionState,
                                    initialData: BluetoothConnectionState.disconnected,
                                    builder: (c, snapshot) {
                                      if (snapshot.data == BluetoothConnectionState.connected) {
                                        return CustomButton(
                                            height: 50.h,
                                            width: 110.w,
                                            onTap: (){
                                              printTicket().then((value) {
                                                if(value == "OK"){
                                                  context.read<GeneralNotifier>().bluetoothPrinterMacId = d.remoteId.toString();
                                                  showAwesomeDialogue(title: "Success", content: "Your printer is ready to use", type: DialogType.SUCCES);
                                                }
                                              });
                                            }, title: "Test Print"
                                        );
                                      }
                                      if (snapshot.data == BluetoothConnectionState.disconnected) {
                                        return CustomButton(
                                            height: 50.h,
                                            width: 110.w,
                                            onTap: (){
                                          isConnectingOrDisconnecting[d.remoteId] ??= ValueNotifier(true);
                                          isConnectingOrDisconnecting[d.remoteId]!.value = true;
                                          d.connect(timeout: Duration(seconds: 35)).catchError((e) {
                                            final snackBar = snackBarFail(prettyException("Connect Error:", e));
                                            snackBarKeyC.currentState?.removeCurrentSnackBar();
                                            snackBarKeyC.currentState?.showSnackBar(snackBar);
                                          }).then((v) {
                                            isConnectingOrDisconnecting[d.remoteId] ??= ValueNotifier(false);
                                            isConnectingOrDisconnecting[d.remoteId]!.value = false;
                                            setState(() {
                                              name = d.localName;
                                            });
                                            setConnect(d.remoteId.toString()).then((value) {
                                              printTicket().then((value) {
                                                if(value == "OK"){
                                                  context.read<GeneralNotifier>().bluetoothPrinterMacId = d.remoteId.toString();
                                                  showAwesomeDialogue(title: "Success", content: "Your printer is ready to use", type: DialogType.SUCCES);
                                                }
                                              });
                                            });
                                          });
                                        }, title: "Connect"
                                         );
                                      }
                                      return Text(snapshot.data.toString().toUpperCase().split('.')[1],style: getSemiBoldStyle(color: Colors.black),);
                                    },
                                  ),
                                ))
                                    .toList(),
                              ),
                            ),
                kDivider,
                StreamBuilder<List<ScanResult>>(
                  stream: FlutterBluePlus.scanResults,
                  initialData: const [],
                  builder: (c, snapshot) => Column(
                    children: (snapshot.data ?? []).map((r) => ScanResultTile(
                        result: r,
                        isConnect: false,
                        onTap: (){
                          isConnectingOrDisconnecting[r.device.remoteId] ??= ValueNotifier(true);
                          isConnectingOrDisconnecting[r.device.remoteId]!.value = true;
                          r.device.connect(timeout: Duration(seconds: 35)).catchError((e) {
                            final snackBar = snackBarFail(prettyException("Connect Error:", e));
                            snackBarKeyC.currentState?.removeCurrentSnackBar();
                            snackBarKeyC.currentState?.showSnackBar(snackBar);
                          }).then((v) {
                            isConnectingOrDisconnecting[r.device.remoteId] ??= ValueNotifier(false);
                            isConnectingOrDisconnecting[r.device.remoteId]!.value = false;
                            setState(() {
                              name = r.device.localName;
                            });
                            setConnect(r.device.remoteId.toString()).then((value) {

                              printTicket().then((value) {
                                if(value == "OK"){
                                  context.read<GeneralNotifier>().bluetoothPrinterMacId = r.device.remoteId.toString();
                                  showAwesomeDialogue(title: "Success", content: "Your printer is ready to use", type: DialogType.SUCCES);
                                }
                              });
                            });
                          });


                        }
                      ),
                    )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: FlutterBluePlus.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data ?? false) {
              return FloatingActionButton(

                foregroundColor: ColorManager.white,
                child: const Icon(Icons.stop),
                onPressed: () async {
                  try {
                    FlutterBluePlus.stopScan();
                  } catch (e) {
                    final snackBar = snackBarFail(prettyException("Stop Scan Error:", e));
                    snackBarKeyB.currentState?.removeCurrentSnackBar();
                    snackBarKeyB.currentState?.showSnackBar(snackBar);
                  }
                },
                backgroundColor: ColorManager.onPrimaryLight,
              );
            } else {
              return FloatingActionButton(
                  child: const Text("SCAN"),
                  foregroundColor: ColorManager.white,

                  onPressed: () async {
                    try {
                      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15), androidUsesFineLocation: false);
                    } catch (e) {
                      final snackBar = snackBarFail(prettyException("Start Scan Error:", e));
                      snackBarKeyB.currentState?.removeCurrentSnackBar();
                      snackBarKeyB.currentState?.showSnackBar(snackBar);
                    }
                    setState(() {}); // force refresh of connectedSystemDevices
                  });
            }
          },
        ),
      ),
    );
  }
}


String prettyException(String prefix, dynamic e) {
  if (e is FlutterBluePlusException) {
    return "$prefix ${e.description}";
  } else if (e is PlatformException) {
    return "$prefix ${e.message}";
  }
  return prefix + e.toString();
}

///
///
///
