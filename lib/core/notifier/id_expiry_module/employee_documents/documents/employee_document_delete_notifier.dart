import 'package:flutter/material.dart';

import '../../../../../constants/color_manger.dart';
import '../../../../../constants/constants.dart';
import '../../../../api/id_expiry_module/employee_document/documents/employee_document_delete_api.dart';



class EmployeeDocumentDeleteNotifier extends ChangeNotifier {
  final EmployeeDocumentDeleteApi _deleteEmployeeDocumentApi =
  EmployeeDocumentDeleteApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  Future<void> deleteEmployeeDocument({
    required BuildContext context,
    required int companyID,
    required int branchID,
    required int documentId,
    required int employeeID,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _deleteEmployeeDocumentApi.employeeDocumentDeleteApi(
        companyID: companyID,
        branchID: branchID,
        documentId: documentId,
        employeeID: employeeID,
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
