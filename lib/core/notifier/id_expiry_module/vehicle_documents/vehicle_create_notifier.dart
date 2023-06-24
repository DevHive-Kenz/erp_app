import 'package:flutter/material.dart';
import 'package:kenz_app/core/notifier/id_expiry_module/vehicle_documents/vehicle_list_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/vehicle_document/vehicle_create_api.dart';

class VehicleCreateNotifier extends ChangeNotifier {
  final VehicleCreateApi _vehicleCreateApi = VehicleCreateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get statusCode => _statusCode;

  Future<void> createVehicle({
    required BuildContext context,
    required String name,
    required String numberPlate,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;

      final data = await _vehicleCreateApi.vehicleCreateApi(
        companyID: companyID!,
        model: "model",
        name: name,
        numberPlate: numberPlate,
        branchID: branchID!,
        year: 0000,
      );


      if (data != null && (data["status"] == 201 || data["status"] == 200)) {
        await context.read<VehicleListNotifier>().fetchVehicleList(context: context);
        // Success message
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
      // Handle any exceptions or errors
      print("Error creating vehicle: $error");
      _isLoading = false;
      notifyListeners();
    }
  }
}
