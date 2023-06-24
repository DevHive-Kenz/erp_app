import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/employee_document/employee_update_api.dart';

class EmployeeUpdateNotifier extends ChangeNotifier {
  final EmployeeUpdateApi _updateEmployeeApi = EmployeeUpdateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get statusCode => _statusCode;

  Future<void> updateEmployee({
    required BuildContext context,
    required String iqama,
    required String employeeName,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;
      int? employeeID = context.read<GeneralNotifier>().getSelectedListDocumentID;
      final data = await _updateEmployeeApi.employeeUpdateApi(
        companyID: companyID!,
        branchID: branchID!,
        employeeID: employeeID!,
        iqama: iqama,
        employeeName: employeeName,
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
      _isLoading = false;
      notifyListeners();
      showSnackBar(
        context: context,
        text: 'An error occurred. Please try again later.',
      );
    }
  }
}
