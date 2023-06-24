import 'package:flutter/material.dart';
import 'package:kenz_app/core/notifier/id_expiry_module/vehicle_documents/vehicle_list_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/vehicle_document/vehicle_delete_api.dart';

class VehicleDeleteNotifier extends ChangeNotifier {
  final VehicleDeleteApi _vehicleDeleteApi = VehicleDeleteApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get statusCode => _statusCode;

  Future<void> deleteVehicle({
    required BuildContext context,

  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;
      int? vehicleId = context.read<GeneralNotifier>().getSelectedListDocumentID;

      final data = await _vehicleDeleteApi.vehicleDeleteApi(
        companyID: companyID!,
        branchID: branchID!,
        vehicleId: vehicleId!,
      );

      if (data != null && (data["status"] == 201 || data["status"] == 200)) {
        // Success message
        await context.read<VehicleListNotifier>().fetchVehicleList(context: context);
        Navigator.pop(context);
        showSnackBar(context: context, text: data["message"], color: ColorManager.green);
        // Navigator.pushReplacementNamed(context, mainRoute);
      } else {
        // Error message
        showSnackBar(context: context, text: data["message"]);
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      showSnackBar(
        context: context,
        text: "An error occurred",
      );
      _isLoading = false;
      notifyListeners();
    }
  }


}
