

import 'package:kenz_app/core/notifier/company/company_delete_notifier.dart';
import 'package:kenz_app/core/notifier/company/company_update_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/notifier/auth/auth_notifier.dart';
import '../core/notifier/branch/branch_create_notifier.dart';
import '../core/notifier/branch/branch_delete_notifier.dart';
import '../core/notifier/branch/branch_list_notifier.dart';
import '../core/notifier/branch/branch_update_notifier.dart';
import '../core/notifier/company/company_List_notifier.dart';
import '../core/notifier/company/company_create_notifier.dart';
import '../core/notifier/id_expiry_module/company_documents/company_document_create_notifier.dart';
import '../core/notifier/id_expiry_module/company_documents/company_document_delete_notifier.dart';
import '../core/notifier/id_expiry_module/company_documents/company_document_list_notifier.dart';
import '../core/notifier/id_expiry_module/company_documents/company_document_update_notifier.dart';
import '../core/notifier/id_expiry_module/employee_documents/employee_create_notifier.dart';
import '../core/notifier/id_expiry_module/employee_documents/employee_delete_notifier.dart';
import '../core/notifier/id_expiry_module/employee_documents/employee_list_notifier.dart';
import '../core/notifier/id_expiry_module/employee_documents/employee_update_notifier.dart';
import '../core/notifier/id_expiry_module/vehicle_documents/vehicle_create_notifier.dart';
import '../core/notifier/id_expiry_module/vehicle_documents/vehicle_delete_notifier.dart';
import '../core/notifier/id_expiry_module/vehicle_documents/vehicle_list_notifier.dart';
import '../core/notifier/id_expiry_module/vehicle_documents/vehicle_update_notifier.dart';
import 'general_notifier.dart';

List<SingleChildWidget> providers = [...providersList];

//independent providers
List<SingleChildWidget> providersList = [

  ChangeNotifierProvider(create: (_) => GeneralNotifier()),
  ChangeNotifierProvider(create: (_) => AuthNotifier()),

//  company
  ChangeNotifierProvider(create: (_) => CompaniesListNotifier()),
  ChangeNotifierProvider(create: (_) => CompanyCreateNotifier()),
  ChangeNotifierProvider(create: (_) => CompanyDeleteNotifier()),
  ChangeNotifierProvider(create: (_) => CompanyUpdateNotifier()),

  //branch
  ChangeNotifierProvider(create: (_) => BranchUpdateNotifier()),
  ChangeNotifierProvider(create: (_) => BranchListNotifier()),
  ChangeNotifierProvider(create: (_) => BranchDeleteNotifier()),
  ChangeNotifierProvider(create: (_) => BranchCreateNotifier()),

  //Employee Document
  //List
  ChangeNotifierProvider(create: (_) => EmployeeUpdateNotifier()),
  ChangeNotifierProvider(create: (_) => EmployeeListNotifier()),
  ChangeNotifierProvider(create: (_) => EmployeeDeleteNotifier()),
  ChangeNotifierProvider(create: (_) => EmployeeCreateNotifier()),

  //Company Document
  ChangeNotifierProvider(create: (_) => CompanyCreateDocumentNotifier()),
  ChangeNotifierProvider(create: (_) =>CompanyDocumentListNotifier()),
  ChangeNotifierProvider(create: (_) => CompanyDocumentDeleteNotifier()),
  ChangeNotifierProvider(create: (_) => CompanyUpdateDocumentNotifier()),
  //Vehicle Document
  //List
  ChangeNotifierProvider(create: (_) => VehicleUpdateNotifier()),
  ChangeNotifierProvider(create: (_) => VehicleListNotifier()),
  ChangeNotifierProvider(create: (_) => VehicleDeleteNotifier()),
  ChangeNotifierProvider(create: (_) => VehicleCreateNotifier()),
];