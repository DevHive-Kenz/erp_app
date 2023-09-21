// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kenz_app/models/customer_model/customer_model.dart';
import 'package:kenz_app/models/product_model/product_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../models/sales_return_model/sales_return_model.dart';
import '../../api/customer_api/customer_api.dart';
import '../../api/product_api/products_api.dart';
import '../../api/sales_api/sales_return_api.dart';
import '../../service/shared_preferance_service.dart';



class ProductNotifier extends ChangeNotifier {
  final ProductsApi _productsApi = ProductsApi();

  bool _isLoading = false;
  int? _statusCode;
  ProductModel? _productModelData;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  ProductModel? get getProductModelData => _productModelData;

  Future<String?> product({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      // final generalNotifier = context.read<GeneralNotifier>();
      final listData = await _productsApi.product();
       print("eeeeee ${listData["status"]}");
      if(listData["status"] == 200){
        _isLoading = false;
        _productModelData = ProductModel.fromJson(listData);
        notifyListeners();
        return "OK";
      }else{
        _isLoading = false;
        notifyListeners();
        showAwesomeDialogue(title: "Warning", content: "Please try againw", type: DialogType.WARNING,);
      }

      _isLoading = false;
      notifyListeners();
    } catch(error){
      print(error);
      showAwesomeDialogue(title: "Warning", content: "Please try again later", type: DialogType.WARNING,);
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}