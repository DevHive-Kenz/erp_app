import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:kenz_app/constants/string_manager.dart';
import 'package:provider/provider.dart';


import 'database_functionalities_notifier.dart';
class DataBaseFetch extends ChangeNotifier {



  Future<void> fetchProducts ({required BuildContext context}) async {
    final dbNotifier = context.read<DataBaseFunctionalities>();
    await dbNotifier.fetchDatabase(dbName: "productList");
    final data = dbNotifier.getFetchedData;
    // _fetchedProducts = data;
    notifyListeners();
  }


}