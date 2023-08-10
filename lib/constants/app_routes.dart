
import 'package:kenz_app/screens/home_screen/home_screen.dart';
import '../screens/home_screen/stock_view_screen.dart';
import '../screens/home_screen/stock_take_screen.dart';
import '../screens/login_screen/intro.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/main_sceen.dart';


const String mainRoute = "/mainRoute";
const String introRoute = "/introRoute";
const String loginRoute = "/loginRoute";
const String homeRoute = "/homeRoute";
const String stockTakeScreen = "/stockTakeScreen";
const String stockViewScreen = "/stockViewScreen";




final routes = {
  mainRoute: (context) => const MainScreen(),
  introRoute: (context) => const SplashScreen(),
  loginRoute: (context) =>  const LoginScreen(),
  homeRoute: (context) =>  const HomeScreen(),
  stockTakeScreen: (context) =>  const StockTakeScreen(),
  stockViewScreen: (context) =>  const StockViewScreen(),
};
