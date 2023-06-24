import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../constants/color_manger.dart';
import '../constants/values_manger.dart';
import '../models/push_notification_model.dart';
import '../provider/general_notifier.dart';
import 'company_screen/company_screen.dart';
import '../../core/notifier/company/company_List_notifier.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  PushNotification? _notificationInfo;
  Future<void> overlayPushNotification() async {

    print("heellooo");
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge:true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Parse the message received
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      if(message.notification?.body !=null){
        setState(() {
          _notificationInfo = notification;
        });
        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          AwesomeDialog(
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.NO_HEADER,
            animType: AnimType.BOTTOMSLIDE,
            title: _notificationInfo!.title!,
            desc: _notificationInfo!.body!,
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            btnOkText: 'ok',
            btnOkColor: ColorManager.primaryLight,
            // btnOkOnPress: () async {
            //   Navigator.pushReplacementNamed(context, loginRoute);
            //   // await  context.read<AuthForceLoginNotifier>().forceFullyLogin(username: username, password: password);
            // },
          ).show();

        }
      }

   });

 }
  int index = 0;
  late final  themeNotifier;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
super.initState();
  }

  _asyncMethod() async {
    await Future.wait([
     context.read<GeneralNotifier>().checkAxisCount(context: context),
     context.read<GeneralNotifier>().getUserNameFun(),
      context.read<CompaniesListNotifier>().fetchCompaniesList(context: context)
    ]);
  }

  final pages = <Widget>[
const CompanyScreen()
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