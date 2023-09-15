
import 'package:kenz_app/screens/home_screen/home_screen.dart';
import '../screens/home_screen/settings_screen.dart';
import '../screens/login_screen/intro.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/main_sceen.dart';
import '../screens/sales_invoice/sales_add_item_screen.dart';
import '../screens/sales_invoice/sales_invoice_screen.dart';
import '../screens/sales_invoice/sales_item_adding_screen.dart';


const String mainRoute = "/mainRoute";
const String introRoute = "/introRoute";
const String loginRoute = "/loginRoute";
const String homeRoute = "/homeRoute";
const String settingsScreen = "/settingsScreen";
const String sales = "/sales";
const String salesItemAdding = "/salesItemAdding";
const String salesAddScreen = "/salesAddScreen";





final routes = {
  mainRoute: (context) => const MainScreen(),
  introRoute: (context) => const SplashScreen(),
  loginRoute: (context) =>  const LoginScreen(),
  homeRoute: (context) =>  const HomeScreen(),
  settingsScreen: (context) =>  const SettingsScreen(),
  sales: (context) =>  const SalesScreen(),
  salesItemAdding: (context) =>  const SalesItemAddingScreen(),
  salesAddScreen: (context) =>  const SalesAddScreen(),

};
