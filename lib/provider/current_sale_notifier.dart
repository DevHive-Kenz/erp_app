

import 'package:flutter/cupertino.dart';

import '../models/customer_model/customer_result_model.dart';
import '../models/product_model/product_base_price_data_model.dart';
import '../models/product_model/product_items_model.dart';
import '../models/product_model/product_model.dart';
import '../models/product_model/product_result_model.dart';
import '../models/product_model/product_unit_conversion_model.dart';
import '../models/total_invoice_model/total_invoice_items_model.dart';

class CurrentSaleNotifier extends ChangeNotifier{

  int? _user;
  int? _saleId;
  int? _soldTo;
  String? _soldToName;
  String? _printType;
  int? _seriesID;
  String? _displaySeriesId;
  DateTime? _date;
  String? _poNumber;
  String? _poDate;
  String? _paymentMethod = "CASH";
  double _vatPercent = 15;
  CustomerResultModel? _selectedCustomer;
  ProductResultModel? _selectedProduct;
  ProductItemsModel? _selectedPriceList;
  ProductUnitConversionDataModel? _selectedConversion;
  ProductItemsModel? _selectedPriceFromConvItems;
  List<ProductUnitConversionDataModel> _uomWithBase = [];
  List _items = [];

  double? _totalDisc=0.00;
  double? _totalVat=0.00;
  double? _totalQTY=0.00;
  double? _totalSub=0.00;
  double? _totalAmount=0.00;

  List get getItemList => _items;
  ProductResultModel? get getSelectedProduct => _selectedProduct;
  ProductItemsModel? get getSelectedPriceList => _selectedPriceList;
  ProductItemsModel? get getSelectedPriceFromConvItems => _selectedPriceFromConvItems;
  double get getVatPercent => _vatPercent;
  ProductUnitConversionDataModel? get getSelectedConversion=> _selectedConversion;
  CustomerResultModel? get getSelectedCustomer => _selectedCustomer;
  List<ProductUnitConversionDataModel> get getUOMWithBase => _uomWithBase;

  double? get getTotalDisc => _totalDisc;
  double? get getTotalVat => _totalVat;
  double? get getTotalQty => _totalQTY;
  double? get getTotalSub => _totalSub;
  double? get getTotalAmount => _totalAmount;

  int? get getUserID => _user;
  int? get getSaleID => _saleId;
  int? get getSoldToID =>_soldTo;
  String? get getSoldToName => _soldToName;
  String? get getPaymentMethod => _paymentMethod;
  String? get getPrintType => _printType;
  int? get getSeriesID => _seriesID;
  DateTime? get getDate => _date;
  String? get getPoNumber => _poNumber;
  String? get getPoDate => _poDate;
  String? get getDisplaySeriesID => _displaySeriesId;

void deleteAnItem({required int index}){

  _items.removeAt(index);
  // print("ddddddddddd");
  calculate();

  notifyListeners();
}

  void clearVariables(){
    _selectedPriceFromConvItems = null;
    _selectedConversion = null;
    _selectedPriceList=null;
    _selectedProduct=null;
    _vatPercent = 15;
    _uomWithBase=[];
    notifyListeners();

    print(_uomWithBase);
  }

  void clearList(){
    _items = [];
        notifyListeners();
  }

  void setInvoiceID({required int invoiceId, required String displaySeriesId}){
    _displaySeriesId = displaySeriesId;
    _seriesID = invoiceId;
    notifyListeners();
  }


  void clearAll(){
    clearVariables();
    _totalDisc=0.00;
    _totalVat=0.00;
    _totalQTY=0.00;
    _totalSub=0.00;
    _totalAmount=0.00;
    _saleId = null;
    _user=null;
    _soldTo=null;
    // _invoiceId=null;
    _printType=null;
    _soldToName=null;
    _poDate=null;
    _poNumber=null;
    _date=null;
    // _displayInvoiceId=null;
    _selectedPriceFromConvItems=null;
    _selectedConversion=null;
    _selectedPriceList=null;
    _selectedProduct=null;
    _selectedCustomer=null;
    _vatPercent=0;
    _paymentMethod="CASH";
    _items=[];
    _uomWithBase=[];

    notifyListeners();
  }

    void setCustomerData({required CustomerResultModel dataCustomer}){
      _selectedCustomer = dataCustomer;
    notifyListeners();
    }


  void setSalesFirstData({required CustomerResultModel dataCustomer,required int user,required int? soldTo,required String printType,required DateTime date, required String soldToName, String? poNumber, String? poDate}){
    _user = user;
    _soldTo = soldTo;
    _printType = printType;
    _date = date;
    _soldToName = soldToName;
    _poNumber = poNumber ?? "---";
    _poDate = poDate;
    _selectedCustomer = dataCustomer;
    _items = [];
    notifyListeners();

  }

  set setSalesId( int? id){
  _saleId = id;
  notifyListeners();
  }

  set setProduct (ProductResultModel data){
    _selectedProduct = data;
    print("qwe ${data.unitConversionData?.length}");
    notifyListeners();
  }

  set setUOMWithBase(List<ProductUnitConversionDataModel> uomWithBase){
    _uomWithBase =[];
    _uomWithBase = uomWithBase;
    notifyListeners();
  }

  set setPriceList(ProductItemsModel data){
    _selectedPriceList = data;
    _uomWithBase = _selectedProduct?.unitConversionData ?? [];
    if (!_uomWithBase.any((item) => item.toUnit == (_selectedProduct?.baseUnitName ?? ""))) {
      _uomWithBase.add(ProductUnitConversionDataModel(
        price: null,
        qty: "1",
        barcode: [],
        toUnit: _selectedProduct?.baseUnitName ?? "",
        toUnitName: _selectedProduct?.baseUnitName ?? "",
        items: _selectedProduct?.basePriceData ?? [],
      ));
    }
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
    _selectedPriceFromConvItems = data;
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

  set setRecentProductList (List<TotalInvoiceItemsModel> data){
  _items.clear();
  notifyListeners();
    data.forEach((element) {
      
      print("333333333${element.price}");
      _items.add({
        "item": element.item ?? "",
        "quantity": element.quantity,
        "unit":element.unit,
        "price": element.price,
        "tax":element.tax,
        "tax_amount":element.taxAmount,
        "discount": element.discount,
        "discount_amount": element.discountAmount,
        "total_amount": element.totalAmount,
        "subTotal": (element.totalAmount ?? 0) - (element.taxAmount ?? 0),
      });
      notifyListeners();

    });
    calculate();
    notifyListeners();
  }

  void updateProductList(Map<String,dynamic> data,index){
    _items[index] = data;
    notifyListeners();
  }

  void calculate(){
    _totalDisc=0.00;
    _totalVat=0.00;
    _totalQTY=0.00;
    _totalSub=0.00;
    _totalAmount=0.00;
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