

import 'package:flutter/cupertino.dart';

import '../models/customer_model/customer_result_model.dart';
import '../models/product_model/product_base_price_data_model.dart';
import '../models/product_model/product_items_model.dart';
import '../models/product_model/product_model.dart';
import '../models/product_model/product_result_model.dart';
import '../models/product_model/product_unit_conversion_model.dart';

class CurrentSaleNotifier extends ChangeNotifier{

  int? _user;
  int? _soldTo;
  String? _soldToName;
  String? _printType;
  int? _invoiceId;
  String? _displayInvoiceId;
  DateTime? _date;
  String? _poNumber;
  String? _poDate;
  String? _paymentMethod;
  double _vatPercent = 15;
  CustomerResultModel? _selectedCustomer;
  ProductResultModel? _selectedProduct;
  ProductBasePriceDataModel? _selectedPriceList;
  ProductUnitConversionDataModel? _selectedConversion;
  ProductItemsModel? _selectedPriceFromConv;
  List _items = [];

  double? _totalDisc=0.00;
  double? _totalVat=0.00;
  double? _totalQTY=0.00;
  double? _totalSub=0.00;
  double? _totalAmount=0.00;

  List get getItemList => _items;
  ProductResultModel? get getSelectedProduct => _selectedProduct;
  ProductBasePriceDataModel? get getSelectedPriceList => _selectedPriceList;
  ProductItemsModel? get getSelectedPriceFromConv => _selectedPriceFromConv;
  double get getVatPercent => _vatPercent;
  ProductUnitConversionDataModel? get getSelectedConversion=> _selectedConversion;
  CustomerResultModel? get getSelectedCustomer => _selectedCustomer;

  double? get getTotalDisc => _totalDisc;
  double? get getTotalVat => _totalVat;
  double? get getTotalQty => _totalQTY;
  double? get getTotalSub => _totalSub;
  double? get getTotalAmount => _totalAmount;

  int? get getUserID => _user;
  int? get getSoldToID =>_soldTo;
  String? get getSoldToName => _soldToName;
  String? get getPaymentMethod => _paymentMethod;
  String? get getPrintType => _printType;
  int? get getInvoiceID => _invoiceId;
  DateTime? get getDate => _date;
  String? get getPoNumber => _poNumber;
  String? get getPoDate => _poDate;
  String? get getDisplayInvoiceID => _displayInvoiceId;

  void clearVariables(){
    _selectedPriceFromConv = null;
    _selectedConversion = null;
    _selectedPriceList=null;
    _selectedProduct=null;
    _vatPercent = 15;
    notifyListeners();
  }

  void clearList(){
    _items = [];
        notifyListeners();
  }

  void clearAll(){
    clearVariables();
    _totalDisc=0.00;
    _totalVat=0.00;
    _totalQTY=0.00;
    _totalSub=0.00;
    _totalAmount=0.00;
    _user=null;
    _soldTo=null;
    _invoiceId=null;
    _printType=null;
    _soldToName=null;
    _poDate=null;
    _poNumber=null;
    _date=null;
    _displayInvoiceId=null;
    _selectedPriceFromConv=null;
    _selectedConversion=null;
    _selectedPriceList=null;
    _selectedProduct=null;
    _selectedCustomer=null;
    _vatPercent=15;
    _paymentMethod=null;
    _items=[];
    notifyListeners();
  }


  void setSalesFirstData({required CustomerResultModel dataCustomer,required int user,required int? soldTo,required String printType,required int invoiceId,required DateTime date, required String soldToName,required String displayInvoiceId, String? poNumber, String? poDate}){
    _user = user;
    _soldTo = soldTo;
    _printType = printType;
    _invoiceId = invoiceId;
    _date = date;
    _soldToName = soldToName;
    _poNumber = poNumber;
    _poDate = poDate;
    _selectedCustomer = dataCustomer;
    _displayInvoiceId = displayInvoiceId;
    _items = [];
    notifyListeners();

  }

  set setProduct (ProductResultModel data){
    _selectedProduct = data;
    notifyListeners();
  }

  set setPriceList(ProductBasePriceDataModel data){
    _selectedPriceList = data;
    notifyListeners();
  }

  set setConversion (ProductUnitConversionDataModel data){
    _selectedConversion = data;
    notifyListeners();
  }

  set setCustomer (CustomerResultModel data){
    _selectedCustomer = data;
    notifyListeners();
  }

  set setPaymentMethod (String data){
    _paymentMethod = data;
    notifyListeners();
  }

  set setPriceFromConversion (ProductItemsModel data){
    _selectedPriceFromConv = data;

    notifyListeners();
  }

  set setVatPercent (String data){
    _vatPercent = double.parse(data);
    notifyListeners();
  }

  set setProductList (Map<String,dynamic> data){
    _items.add(data);
    notifyListeners();
  }

  void calculate(){
    _totalDisc=0.00;
    _totalVat=0.00;
    _totalQTY=0.00;
    _totalSub=0.00;
    for (var element in _items) {
       _totalDisc = (_totalDisc ?? 0.00) + (element["discount_amount"] ?? 0.00);
       _totalVat = (_totalVat ?? 0.00) + (element["tax_amount"] ?? 0.00);
       _totalQTY = (_totalQTY ?? 0.00) + (element["quantity"] ?? 0.00);
       _totalSub = (_totalSub ?? 0.00) + (element["subTotal"] ?? 0.00);
       _totalAmount = (_totalAmount ?? 0.00) + (element["total_amount"] ?? 0.00);
    }
    notifyListeners();
  }



}