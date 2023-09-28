import 'dart:collection';
import 'package:flutter/material.dart';

import '../models/customer_model/customer_result_model.dart';
import '../models/product_model/product_result_model.dart';
import '../models/total_invoice_model/total_invoice_result_model.dart';

class SearchProvider extends ChangeNotifier {

  String _searchString ="";
  DateTime? _startDate = DateTime.now();
  DateTime? _endDate = DateTime.now();

  List<CustomerResultModel> _customerList = [];
  List<ProductResultModel> _productList = [];
  List<TotalInvoiceResultModel> _totalInvoiceList = [];


  UnmodifiableListView get getCustomerList=> _searchString.isEmpty
      ? UnmodifiableListView(_customerList)
      : UnmodifiableListView(_customerList.where((value) =>
      ("${value.name}${value.nameArabic}").toString().toLowerCase().contains(_searchString.toLowerCase())));

  UnmodifiableListView get getProductList=> _searchString.isEmpty
      ? UnmodifiableListView(_productList)
      : UnmodifiableListView(_productList.where((value) =>
      ("${value.sku}${value.name}${value.nameArabic}${value.itemCode}${value.barCode?.join()}").toString().toLowerCase().contains(_searchString.toLowerCase())));

  UnmodifiableListView get getInvoiceList=> _startDate == null && _endDate ==null
      ? UnmodifiableListView(_totalInvoiceList)
      : UnmodifiableListView(_totalInvoiceList.where((value) =>
  value.date!.isAtSameMomentAs(_startDate!)||value.date!.isAtSameMomentAs(_endDate!)||(value.date!.isAfter(_startDate!) && value.date!.isBefore(_endDate!.add(Duration(days: 1))))));




  void cleanSearchString() {
    _searchString = "";
    _endDate=null;
    _startDate=null;
    notifyListeners();
    print(_searchString);
  }

  void changeSearchString(String searchString) {
    _searchString = searchString;
    notifyListeners();
    print(_searchString);
  }

  void setStartAndEndDate({required DateTime startDate, required DateTime endDate}){
    _startDate = startDate;
    _endDate = endDate;
    notifyListeners();
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

  void initializeTotalList(  List<TotalInvoiceResultModel>? list ){
    _searchString = "";
    _totalInvoiceList=list!;
    notifyListeners();
  }
}