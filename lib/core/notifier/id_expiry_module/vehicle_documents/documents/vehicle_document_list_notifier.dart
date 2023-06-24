import 'package:flutter/material.dart';

import '../../../../../constants/constants.dart';
import '../../../../../models/id_expiry_module/vehicle_document/vehicle_document_list_model/vehicle_document_list_model.dart';
import '../../../../api/id_expiry_module/vehicle_document/documents/vehicle_document_list_api.dart';

class VehicleDocumentListNotifier extends ChangeNotifier {
  final VehicleDocumentList _vehicleDocumentListAPI = VehicleDocumentList();

  bool _isLoading = false;
  VehicleDocumentListModel? _documents;
  int? _statusCode;

  bool get isLoading => _isLoading;
  VehicleDocumentListModel? get documents => _documents;
  int? get statusCode => _statusCode;

  Future<void> fetchVehicleDocumentList({
    required BuildContext context,
    required int companyID,
    required int branchID,
    required int vehicleID,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _vehicleDocumentListAPI.vehicleDocumentList(
        companyID: companyID,
        branchID: branchID,
        vehicleID: vehicleID,
      );
      _statusCode = data["status"];
      if (_statusCode == 200) {
        _documents = VehicleDocumentListModel.fromJson(data);
        notifyListeners();
        // Navigator.pushReplacementNamed(context, mainRoute);
      } else {
        showSnackBar(context: context, text: data["message"]);
      }
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
