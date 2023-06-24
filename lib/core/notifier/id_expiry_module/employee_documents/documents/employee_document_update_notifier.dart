import 'package:flutter/cupertino.dart';

import '../../../../../constants/color_manger.dart';
import '../../../../../constants/constants.dart';
import '../../../../api/id_expiry_module/employee_document/documents/employee_document_update_api.dart';

class EmployeeDocumentUpdateNotifier extends ChangeNotifier {
  final EmployeeDocumentUpdateApi _updateEmployeeDocumentAPI =
  EmployeeDocumentUpdateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  Future<void> updateEmployeeDocument({
    required BuildContext context,
    required int companyID,
    required int branchID,
    required int employeeID,
    required int documentId,
    required String documentType,
    required String documentNo,
    required String expiry,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _updateEmployeeDocumentAPI.employeeDocumentUpdateApi(
        companyID: companyID,
        branchID: branchID,
        employeeID: employeeID,
        documentId: documentId,
        documentType: documentType,
        documentNo: documentNo,
        expiry: expiry,
      );

      if (data != null && (data["status"] == 201 || data["status"] == 200)) {
        showSnackBar(
          context: context,
          text: data["message"],
          color: ColorManager.green,
        );

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
