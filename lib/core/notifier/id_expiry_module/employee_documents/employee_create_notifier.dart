import 'package:flutter/cupertino.dart';
import 'package:kenz_app/core/notifier/id_expiry_module/employee_documents/employee_list_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/string_manager.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/employee_document/employee_create_api.dart';
import '../../../service/shared_preferance_service.dart';

class EmployeeCreateNotifier extends ChangeNotifier {
  final EmployeeCreateApi _createEmployeeAPI = EmployeeCreateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get statusCode => _statusCode;
  CacheService cashService = CacheService();

  Future<void> createEmployee({
    required BuildContext context,

    required String iqama,
    required String employeeName,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;
      String? userID = await cashService.readCache(key: AppStrings.userID);


      final data = await _createEmployeeAPI.employeeCreateApi(
        companyID: companyID!,
        branchID: branchID!,
        iqama: iqama,
        employeeName: employeeName, user: int.parse(userID!),
      );

      if (data != null && (data["status"] == 201 || data["status"] == 200)) {
        // Success message
        await context.read<EmployeeListNotifier>().fetchEmployeeList(context: context);

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
