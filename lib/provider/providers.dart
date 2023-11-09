import 'package:kenz_app/provider/sales_printing_notifier.dart';
import 'package:kenz_app/provider/search_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/notifier/auth/auth_notifier.dart';

import '../core/notifier/customer_crud_notifier/customer_create_notifier.dart';
import '../core/notifier/customer_crud_notifier/customer_delete_notifier.dart';
import '../core/notifier/customer_crud_notifier/customer_edit_notifier.dart';
import '../core/notifier/master_data_notifier/master_data_notifier.dart';
import '../core/notifier/product_notifier/product_notifier.dart';
import '../core/notifier/customer_notifier/customer_notifier.dart';
import '../core/notifier/profile_notifier/profile_notifier.dart';
import '../core/notifier/sales_post_notifier/sales_post_notifier.dart';
import '../core/notifier/sales_return/sales_return_by_id_notifier.dart';
import '../core/notifier/sales_return/sales_return_notifier.dart';
import '../core/notifier/sales_return/sales_return_post_notifier.dart';
import '../core/notifier/series_fetch_notifier/series_fetch_notifier.dart';
import '../core/notifier/total_invoice/total_invoice_notifier.dart';
import 'current_sale_notifier.dart';
import 'dataBase_fetch_notifier.dart';
import 'database_functionalities_notifier.dart';
import 'general_notifier.dart';

List<SingleChildWidget> providers = [...providersList];

//independent providers
List<SingleChildWidget> providersList = [

  ChangeNotifierProvider(create: (_) => GeneralNotifier()),
  ChangeNotifierProvider(create: (_) => AuthNotifier()),
  ChangeNotifierProvider(create: (_) => DataBaseFunctionalities()),
  ChangeNotifierProvider(create: (_) => DataBaseFetch()),
  ChangeNotifierProvider(create: (_) => SearchProvider()),
  ChangeNotifierProvider(create: (_) => SeriesFetchNotifier()),

  ///customer
  ChangeNotifierProvider(create: (_) => ProductNotifier()),
  ChangeNotifierProvider(create: (_) => CustomerCreateNotifier()),
  ChangeNotifierProvider(create: (_) => CustomerEditNotifier()),
  ChangeNotifierProvider(create: (_) => CustomerDeleteNotifier()),
  ChangeNotifierProvider(create: (_) => MasterDataCustomerNotifier()),

  ///sales
  ChangeNotifierProvider(create: (_) => SalesReturnByIdNotifier()),
  ChangeNotifierProvider(create: (_) => SalesReturnNotifier()),
  ChangeNotifierProvider(create: (_) => CurrentSaleNotifier()),
  ChangeNotifierProvider(create: (_) => InvoicePrintingNotifier()),
  ChangeNotifierProvider(create: (_) => SalesPostNotifier()),
  ChangeNotifierProvider(create: (_) => SalesReturnPostNotifier()),

  ///product
  ChangeNotifierProvider(create: (_) => CustomerNotifier()),

  ///profile
  ChangeNotifierProvider(create: (_) => ProfileNotifier()),

  ///total invoice
  ChangeNotifierProvider(create: (_) => TotalInvoiceNotifier()),



];