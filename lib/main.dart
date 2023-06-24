import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kenz_app/provider/providers.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';

// import 'package:lm_pay/screens/intro/splash_screen.dart';
// import 'package:provider/provider.dart';


import 'constants/app_routes.dart';
import 'constants/string_manager.dart';
import 'constants/theme_manager.dart';
import 'core/notifier/auth/auth_notifier.dart';
import 'core/service/shared_preferance_service.dart';

//delete this whenever you got context idea
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final FirebaseMessaging _messaging;

  void requestAndRegisterNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();
    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _messaging.setForegroundNotificationPresentationOptions(badge: true, alert: true, sound: true);
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      String? token = await _messaging.getToken();
      navigatorKey.currentContext?.read<AuthNotifier>().setFirebaseToken(token ?? "");
      print("The token is "+token!);
      // For handling the received notifications
    } else {
      print('User declined or has not accepted permission');
   }
    }


    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    requestAndRegisterNotification();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Builder(builder: (context) {
        return ScreenUtilInit(
          designSize: const Size(360, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_,k) => OverlaySupport(
            child: MaterialApp(

              navigatorKey: navigatorKey,
              scaffoldMessengerKey: snackbarKey,
              theme: getApplicationTheme(),
              debugShowCheckedModeBanner: false,
              routes: routes,
              initialRoute: introRoute,
              // initialRoute: loginRoute,
            ),
          ),
        );
      }),
    );
  }
}


