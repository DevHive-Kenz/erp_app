// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kenz_app/core/api/series_fetch_api/series_fetch_api.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_routes.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../models/sales_return_model/sales_return_model.dart';
import '../../../provider/current_sale_notifier.dart';
import '../../api/sales_api/sales_return/sales_return_by_id_api.dart';
import '../../service/shared_preferance_service.dart';
import '../profile_notifier/profile_notifier.dart';



class SeriesFetchNotifier extends ChangeNotifier {
  final SeriesFetchApi _seriesFetchAPI = SeriesFetchApi();

  bool _isLoading = false;
  int? _statusCode;
  String? _seriesFetch;


  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  String? get getSeriesFetch => _seriesFetch;




  Future<String?> seriesFetch({
    required BuildContext context,
    required String type,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      final generalNotifier = context.read<GeneralNotifier>();
      final currentNotifier = context.read<CurrentSaleNotifier>();
      final profileNotifier = context.read<ProfileNotifier>();

      final listData = await _seriesFetchAPI.seriesFetch(type: type);

      if(listData["status"] == 200){
        _seriesFetch= listData["result"].toString();
        print(listData["result"]);
        print( "pp${generalNotifier.getTypeOfTransaction == Transaction.sales? (profileNotifier.getProfile?.result?[0].companySalePrefix):profileNotifier.getProfile?.result?[0].companySaleReturnPrefix} ${formatString(listData["result"].toString())}");
        currentNotifier.setInvoiceID(invoiceId: listData["result"],displaySeriesId: "${generalNotifier.getTypeOfTransaction == Transaction.sales? (profileNotifier.getProfile?.result?[0].companySalePrefix):profileNotifier.getProfile?.result?[0].companySaleReturnPrefix} ${formatString(listData["result"].toString())}");
        _isLoading = false;
        notifyListeners();
        return "OK";
      }else{
        _isLoading = false;
        notifyListeners();
        showAwesomeDialogue(title: "Warning", content: "Please try again", type: DialogType.WARNING,);
      }

      _isLoading = false;
      notifyListeners();
    } catch(error){
      showAwesomeDialogue(title: "Warning", content: "Please try again later", type: DialogType.WARNING,);
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}