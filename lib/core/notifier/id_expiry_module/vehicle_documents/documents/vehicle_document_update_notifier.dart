import 'package:flutter/cupertino.dart';

import '../../../../../constants/color_manger.dart';
import '../../../../../constants/constants.dart';
import '../../../../api/id_expiry_module/vehicle_document/documents/vehicle_document_update_api.dart';

class VehicleDocumentUpdateNotifier extends ChangeNotifier {
  final VehicleDocumentUpdateApi _updateVehicleDocumentAPI =
  VehicleDocumentUpdateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  Future<void> updateVehicleDocument({
    required BuildContext context,
    required int companyID,
    required int branchID,
    required int vehicleID,
    required int documentId,
    required String documentType,
    required String documentNo,
    required String expiry,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _updateVehicleDocumentAPI.vehicleDocumentUpdateApi(
        companyID: companyID,
        branchID: branchID,
        vehicleID: vehicleID,
        documentId: documentId,
        documentType: documentType,
        documentNo: documentNo,
        expiry: expiry,
      );

      if (data != null && (data["status"] == 201 || data["status"] == 200)) {
        showSnackBar(
          context: context,
          text:data["message"],
          color: ColorManager.green,
        );
      }else{
        showSnackBar(
          context: context,
          text:data["message"],
        );
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      showSnackBar(
        context: context,
        text: "An error occurred while updating the vehicle document.",
      );
    }
  }
}
