import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_manger.dart';
import '../../../constants/constants.dart';
import '../../../provider/general_notifier.dart';
import '../../api/branch/branch_delete_api.dart';
import 'branch_list_notifier.dart';

class BranchDeleteNotifier extends ChangeNotifier {
  final BranchDeleteApi _deleteBranchAPI = BranchDeleteApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  Future<void> deleteBranch({
    required BuildContext context,

  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;


      final data = await _deleteBranchAPI.branchDeleteApi(
        branchID: branchID!,
        companyID: companyID!,
      );

      if (data["status"] == 200||data["status"] == 201) {
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
