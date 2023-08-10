

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:kenz_app/constants/string_manager.dart';
class DataBaseFunctionalities extends ChangeNotifier {
  LazyBox? _box;
  dynamic _fetchedData;

  get getFetchedData => _fetchedData;

  Future<void> saveDataBase({required String dbName, required dbData}) async {
    try {
      if (!(Hive.isBoxOpen(AppStrings.dbName))) {
        _box = await Hive.openLazyBox(AppStrings.dbName);
        _box?.put(dbName, dbData);
      }else{
        _box?.put(dbName, dbData);
      }

    } catch (e) {
      print("db error $e");
    }
  }

  Future<void> fetchDatabase({required String dbName}) async {
    if (!(Hive.isBoxOpen(AppStrings.dbName))) {
      _box = await Hive.openLazyBox(AppStrings.dbName);
      _fetchedData = await _box?.get(dbName);
      notifyListeners();
    }else{
      _fetchedData = await _box?.get(dbName);
      notifyListeners();
    }
  }
}