import 'package:flutter/material.dart';
import 'package:kenz_app/core/notifier/branch/branch_list_notifier.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_manger.dart';
import '../../../constants/constants.dart';
import '../../../provider/general_notifier.dart';
import '../../api/branch/branch_update_api.dart';

class BranchUpdateNotifier extends ChangeNotifier {
  final BranchUpdateApi _updateBranchAPI = BranchUpdateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  Future<void> updateBranch({
    required BuildContext context,
    required String name,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;

      final data = await _updateBranchAPI.branchUpdateApi(
        branchID: branchID,
        name: name,
        companyID: companyID,
      );

      if (data["status"] == 200 || data["status"] == 201) {
        await context.read<BranchListNotifier>().fetchBranchList(context: context);
Navigator.pop(context);
        showSnackBar(
          context: context,
          text: data["message"],
          color: ColorManager.green,
        );

        // Perform any necessary UI updates or navigation here
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
