
import 'package:kenz_app/screens/company_screen/company_screen.dart';

import '../screens/branch_screen/branch_screen.dart';
import '../screens/category_screen/category_screen.dart';
import '../screens/company_screen/company_form_screen.dart';
import '../screens/document_screen/document_list_screen.dart';
import '../screens/login_screen/intro.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/main_sceen.dart';
const String mainRoute = "/mainRoute";
const String introRoute = "/introRoute";
const String companyRoute = "/companyRoute";
const String branchRoute = "/branchRoute";
const String categoryRoute = "/categoryRoute";
const String categoryCompanyRoute = "/categoryCompanyRoute";
const String loginRoute = "/loginRoute";




final routes = {
  mainRoute: (context) => const MainScreen(),
  introRoute: (context) => const SplashScreen(),
  companyRoute: (context) => const CompanyScreen(),
  branchRoute: (context) => const BranchScreen(),
  categoryRoute: (context) => const CategoryScreen(),
  loginRoute: (context) =>  const LoginScreen(),
  categoryCompanyRoute: (context) => const DocumentListScreen(),
};
