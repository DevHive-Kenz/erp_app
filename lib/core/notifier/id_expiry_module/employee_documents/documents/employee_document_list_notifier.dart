import 'package:flutter/cupertino.dart';
import 'package:kenz_app/constants/constants.dart';

import '../../../../../models/id_expiry_module/employee_document/employee_document_list_model/employee_document_list_model.dart';
import '../../../../api/id_expiry_module/employee_document/documents/employee_document_list_api.dart';

class EmployeeDocumentListNotifier extends ChangeNotifier {
  final EmployeeDocumentList _employeeDocumentListAPI = EmployeeDocumentList();

  bool _isLoading = false;
  EmployeeDocumentListModel? _documents;
  int? _statusCode;

  bool get isLoading => _isLoading;
  EmployeeDocumentListModel? get documents => _documents;
  int? get statusCode => _statusCode;

  Future<void> fetchEmployeeDocumentList({
    required BuildContext context,
    required int companyID,
    required int branchID,
    required int employeeID,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _employeeDocumentListAPI.employeeDocumentList(
        companyID: companyID,
        branchID: branchID,
        employeeID: employeeID,
      );

      _statusCode = data["status"];
      if (_statusCode == 201 || _statusCode == 200) {
        _documents = EmployeeDocumentListModel.fromJson(data);
        notifyListeners();
      } else {
       showSnackBar(context: context, text: data["message"]);
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      // Handle any exceptions that occur during the API call
      // You can show an error message or take appropriate action

      _isLoading = false;
      notifyListeners();
    }
  }
}
