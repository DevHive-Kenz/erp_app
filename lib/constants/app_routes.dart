
import 'package:kenz_app/screens/home_screen/home_screen.dart';
import '../screens/home_screen/customer_create_screen/customer_create_screen.dart';
import '../screens/home_screen/printig_screen/invoice_printing_screen.dart';
import '../screens/home_screen/sales_invoice/sales_add_item_screen.dart';
import '../screens/home_screen/sales_invoice/sales_invoice_screen.dart';
import '../screens/home_screen/sales_invoice/sales_item_adding_screen.dart';
import '../screens/home_screen/sales_return/sales_return_screen.dart';
import '../screens/home_screen/settings/bluetooth_printer_setup_screen.dart';
import '../screens/home_screen/settings/printer_settings_screen.dart';
import '../screens/home_screen/settings/settings_screen.dart';
import '../screens/home_screen/total_invoice/total_invoice_screen.dart';
import '../screens/login_screen/intro.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/main_sceen.dart';


const String mainRoute = "/mainRoute";
const String introRoute = "/introRoute";
const String loginRoute = "/loginRoute";
const String homeRoute = "/homeRoute";
const String settingsScreen = "/settingsScreen";
const String sales = "/sales";
const String salesItemAdding = "/salesItemAdding";
const String salesAddScreen = "/salesAddScreen";
const String printerSettingsScreen = "/printerSettingsScreen";
const String bluetoothPrinterScreen = "/bluetoothPrinterScreen";
const String totalInvoice = "/totalInvoice";
const String customerCreateScreen = "/customerCreateScreen";
const String salesReturnScreen = "/salesReturnScreen";
const String invoicePrintingScreen = "/invoicePrintingScreen";





final routes = {
  mainRoute: (context) => const MainScreen(),
  introRoute: (context) => const SplashScreen(),
  loginRoute: (context) =>  const LoginScreen(),
  homeRoute: (context) =>  const HomeScreen(),
  settingsScreen: (context) =>  const SettingsScreen(),
  sales: (context) =>  const SalesScreen(),
  salesItemAdding: (context) =>  const SalesItemAddingScreen(),
  salesAddScreen: (context) =>  const SalesAddScreen(),
  printerSettingsScreen: (context) =>  const PrinterSettingsScreen(),
  bluetoothPrinterScreen: (context) =>  const BluetoothPrinterScreen(),
  totalInvoice: (context) =>  const TotalInvoice(),
  customerCreateScreen: (context) =>  const CustomerCRUDScreen(),
  salesReturnScreen: (context) =>  const SalesReturnScreen(),
  invoicePrintingScreen: (context) =>   InvoicePrintingScreen(),

};
