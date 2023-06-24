import 'package:flutter/material.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../../../models/id_expiry_module/employee_document/employee_list_model.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/employee_document/employee_list_api.dart';

class EmployeeListNotifier extends ChangeNotifier {
  final EmployeeList _employeeListAPI = EmployeeList();

  bool _isLoading = false;
  EmployeeListModel? _employees;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  EmployeeListModel? get getEmployees => _employees;
  int? get statusCode => _statusCode;

  Future<void> fetchEmployeeList({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;

      final data = await _employeeListAPI.employeeList(
        companyID: companyID!,
        branchID: branchID!,
      );
      _statusCode = data["status"];
      if (_statusCode == 200 || _statusCode ==201) {
        _employees = EmployeeListModel.fromJson(data);
        notifyListeners();
      }else{
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
