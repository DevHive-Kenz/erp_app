import 'package:flutter/cupertino.dart';

import '../../../../../constants/color_manger.dart';
import '../../../../../constants/constants.dart';
import '../../../../api/id_expiry_module/employee_document/documents/employee_document_create_api.dart';

class EmployeeCreateDocumentNotifier extends ChangeNotifier {
  final EmployeeDocumentCreateApi _createEmployeeDocumentAPI =
  EmployeeDocumentCreateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  Future<void> postEmployeeDocument({
    required BuildContext context,
    required int companyID,
    required int branchID,
    required int employeeID,
    required String documentType,
    required String documentNo,
    required String expiry,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _createEmployeeDocumentAPI.employeeDocumentCreateApi(
        companyID: companyID,
        branchID: branchID,
        employeeID: employeeID,
        documentType: documentType,
        documentNo: documentNo,
        expiry: expiry,
      );

      if (data["status"] == 200) {
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
      _isLoading = false;
      notifyListeners();
    }
  }
}
