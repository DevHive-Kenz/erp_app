import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../constants/color_manger.dart';
import '../constants/values_manger.dart';
import '../models/push_notification_model.dart';
import '../provider/general_notifier.dart';
import '../core/notifier/product_notifier/product_notifier.dart';
import '../core/notifier/customer_notifier/customer_notifier.dart';
import '../core/notifier/profile_notifier/profile_notifier.dart';
import '../core/notifier/master_data_notifier/master_data_notifier.dart';
import 'home_screen/home_screen.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {




  int index = 0;
  late final  themeNotifier;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _permissions();
      _asyncMethod();
    });
super.initState();
  }

  _permissions(){
    [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request();
  }
  _asyncMethod() async {
    context.read<GeneralNotifier>().setIsLoading = true;
    await Future.wait([
     context.read<GeneralNotifier>().checkAxisCount(context: context),
     context.read<GeneralNotifier>().getUserNameFun(),
     context.read<ProductNotifier>().product(context: context),
      context.read<ProfileNotifier>().profile(context: context),
      context.read<CustomerNotifier>().customer(context: context),
      context.read<MasterDataCustomerNotifier>().masterData(context: context),
    ]);
    context.read<GeneralNotifier>().setIsLoading = false;
  }

  final pages = <Widget>[
const HomeScreen()
    // const StockScreen(),

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: pages[index],
      // bottomNavigationBar: BottomNavigationBar(

          // items:  const <BottomNavigationBarItem>[
          //   // BottomNavigationBarItem(
          //   //   icon: Icon(Icons.stacked_line_chart_rounded),
          //   //   label: "Stocks" ,
          //   // ),
          //   // BottomNavigationBarItem(
          //   //   icon: Icon(Icons.home_filled),
          //   //   label: "Home" ,
          //   // ),
          //   // BottomNavigationBarItem(
          //   //   icon: Icon(Icons.book_rounded),
          //   //   label: "Report",
          //   // ),
          // ],
          // currentIndex: index,
          // onTap: (value){
          //   setState(() {
          //     index = value;
          //   });
      //     }
      // ),
      //

      // TabBarMaterialWidget(
      //   index: index,
      //   onChangedTab: onChangedTab,
      // ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
 });
   }
}