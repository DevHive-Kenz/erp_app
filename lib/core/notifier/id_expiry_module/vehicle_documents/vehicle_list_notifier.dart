import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../models/id_expiry_module/vehicle_document/vehicle_list_model.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/vehicle_document/vehicle_delete_api.dart';
import '../../../api/id_expiry_module/vehicle_document/vehicle_list_api.dart';



class VehicleListNotifier extends ChangeNotifier {


  final VehicleList _vehicleListAPI = VehicleList();

  bool _isLoading = false;
  VehicleListModel? _vehicles;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  VehicleListModel? get getVehicles => _vehicles;
  int? get statusCode => _statusCode;

  Future<void> fetchVehicleList({
    required BuildContext context,

  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;

      final data = await _vehicleListAPI.vehicleList(
        companyID: companyID!,
        branchID: branchID!,
      );
      _statusCode = data["status"];
      notifyListeners();
      if (_statusCode == 201 || _statusCode == 200) {
        _vehicles = VehicleListModel.fromJson(data);
        notifyListeners();
      }else{
        showSnackBar(context: context, text: data['message']);
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
