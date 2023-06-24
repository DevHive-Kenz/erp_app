import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/employee_document/employee_delete_api.dart';

class EmployeeDeleteNotifier extends ChangeNotifier {
  final EmployeeDeleteApi _employeeDeleteApi = EmployeeDeleteApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get statusCode => _statusCode;

  Future<void> deleteEmployee({
    required BuildContext context,

  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;
      int? employeeId = context.read<GeneralNotifier>().getSelectedListDocumentID;

      final data = await _employeeDeleteApi.employeeDeleteApi(
        companyID: companyID!,
        branchID: branchID!,
        employeeId: employeeId!,
      );


      if (data != null && (data["status"] == 201 || data["status"] == 200)) {
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
      _isLoading = false;
      notifyListeners();
    }
  }
}
