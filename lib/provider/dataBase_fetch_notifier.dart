import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:kenz_app/constants/string_manager.dart';
import 'package:provider/provider.dart';

import '../models/barcode_model/barcode_data_list_model.dart';
import '../models/product_model/product_data_list_model.dart';
import '../models/uom_model/uom_data_list_model.dart';
import 'database_functionalities_notifier.dart';
class DataBaseFetch extends ChangeNotifier {

  ProductDataListModel? _fetchedProducts;
  UOMDataListModel? _fetchedUOM;
  BarcodeDataListModel? _fetchedBarcode;

  Map<String,ProductDataListModel>?    _processedListProducts;
  Map<String,UOMDataListModel>?        _processedListUOM;
  Map<String,BarcodeDataListModel>?   _processedListBarcode;

  ProductDataListModel? get getFetchedProducts => _fetchedProducts;
  UOMDataListModel? get getFetchedUOM=> _fetchedUOM;
  BarcodeDataListModel? get getFetchedBarcode=> _fetchedBarcode;
  Map<String,ProductDataListModel>? get getFetchedListProducts =>_processedListProducts;
  Map<String,UOMDataListModel>? get getgetFetchedListUOM => _processedListUOM;
  Map<String,BarcodeDataListModel>? get getFetchedListBarcode => _processedListBarcode;


  Future<void> fetchProducts ({required BuildContext context}) async {
    final dbNotifier = context.read<DataBaseFunctionalities>();
    await dbNotifier.fetchDatabase(dbName: "productList");
    final data = dbNotifier.getFetchedData;
    _fetchedProducts = data;
    notifyListeners();
  }
  Future<void> fetchBarcodes ({required BuildContext context}) async {
    final dbNotifier = context.read<DataBaseFunctionalities>();
    await dbNotifier.fetchDatabase(dbName: "barcodeList");
    final data = dbNotifier.getFetchedData;
    _fetchedBarcode = data;
    notifyListeners();
  }
  Future<void> fetchUOM ({required BuildContext context}) async {
    final dbNotifier = context.read<DataBaseFunctionalities>();
    await dbNotifier.fetchDatabase(dbName: "UOMList");
    final data = dbNotifier.getFetchedData;
    _fetchedUOM = data;
    notifyListeners();
  }

  void setProcessedData({
    required Map<String,ProductDataListModel> products,
    required Map<String,UOMDataListModel> uom,
    required Map<String,BarcodeDataListModel> barcode}){
    _processedListProducts = products;
    _processedListUOM = uom;
    _processedListBarcode = barcode;
    notifyListeners();
  }

}