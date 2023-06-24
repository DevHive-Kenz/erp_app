import 'package:flutter/cupertino.dart';

import '../../../../../constants/color_manger.dart';
import '../../../../../constants/constants.dart';
import '../../../../api/id_expiry_module/vehicle_document/documents/vehicle_document_delete_api.dart';

class VehicleDocumentDeleteNotifier extends ChangeNotifier {
  final VehicleDocumentDeleteApi _deleteVehicleDocumentAPI =
  VehicleDocumentDeleteApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  Future<void> deleteVehicleDocument({
    required BuildContext context,
    required int companyID,
    required int branchID,
    required int documentId,
    required int vehicleID,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _deleteVehicleDocumentAPI.vehicleDocumentDeleteApi(
        companyID: companyID,
        branchID: branchID,
        documentId: documentId,
        vehicleID: vehicleID,
      );

      if (data != null && (data["status"] == 201 || data["status"] == 200)) {
        showSnackBar(
          context: context,
          text: data["message"],
          color: ColorManager.green,
        );
      } else {
        showSnackBar(
          context: context,
          text: "Failed to delete vehicle document.",
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
