import 'package:flutter/material.dart';

import '../../../../../constants/color_manger.dart';
import '../../../../../constants/constants.dart';
import '../../../../api/id_expiry_module/vehicle_document/documents/vehicle_document_create_api.dart';

class VehicleCreateDocumentNotifier extends ChangeNotifier {
  final VehicleDocumentCreateApi _createVehicleDocumentAPI =
  VehicleDocumentCreateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  Future<void> postVehicleDocument({
    required BuildContext context,
    required int companyID,
    required int branchID,
    required int vehicleID,
    required String documentType,
    required String documentNo,
    required String expiry,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _createVehicleDocumentAPI.vehicleDocumentCreateApi(
        companyID: companyID,
        branchID: branchID,
        vehicleID: vehicleID,
        documentType: documentType,
        documentNo: documentNo,
        expiry: expiry,
      );

      if (data["status"] == 200) {
        showSnackBar(
          context: context,
          text: data["message"],
          color: ColorManager.green,
        );

        // Navigator.pushReplacementNamed(context, mainRoute);
      } else {
        showSnackBar(
          context: context,
          text: data["message"],
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
