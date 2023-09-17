import 'dart:collection';
import 'package:flutter/material.dart';

import '../models/customer_model/customer_result_model.dart';
import '../models/product_model/product_result_model.dart';

class SearchProvider extends ChangeNotifier {

  String _searchString ="";

  List<CustomerResultModel> _customerList = [];
  List<ProductResultModel> _productList = [];


  UnmodifiableListView get getCustomerList=> _searchString.isEmpty
      ? UnmodifiableListView(_customerList)
      : UnmodifiableListView(_customerList.where((value) =>
      ("${value.name}${value.nameArabic}").toString().toLowerCase().contains(_searchString.toLowerCase())));

  UnmodifiableListView get getProductList=> _searchString.isEmpty
      ? UnmodifiableListView(_productList)
      : UnmodifiableListView(_productList.where((value) =>
      ("${value.sku}${value.name}${value.nameArabic}${value.itemCode}${value.barCode?.join()}").toString().toLowerCase().contains(_searchString.toLowerCase())));





  void cleanSearchString() {
    _searchString = "";
    notifyListeners();
    print(_searchString);
  }


  void changeSearchString(String searchString) {
    _searchString = searchString;
    notifyListeners();
    print(_searchString);
  }

  void initializeCustomerList(List<CustomerResultModel>? list){
    _searchString = "";
    _customerList=list!;
    notifyListeners();
  }

  void initializeProductList(List<ProductResultModel>? list){
    _searchString = "";
    _productList=list!;
    notifyListeners();
  }
}