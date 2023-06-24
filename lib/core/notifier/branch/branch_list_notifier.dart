import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_manger.dart';
import '../../../constants/constants.dart';
import '../../../models/branch/branch_list_model.dart';
import '../../../provider/general_notifier.dart';
import '../../api/branch/branch_list_api.dart';

class BranchListNotifier extends ChangeNotifier {
  final BranchList _branchListAPI = BranchList();

  bool _isLoading = false;
  int? _statusCode;
  BranchListModel? _branchModel;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;
  BranchListModel? get getBranchModel => _branchModel;

  Future<String?> fetchBranchList({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;

      final data = await _branchListAPI.branchList(companyId: companyID!);

      if (data["status"] == 200) {
        // Handle the retrieved branch list data
        _branchModel = BranchListModel.fromJson(data);
        _isLoading = false;
        notifyListeners();
        return "OK";
      } else {
        showSnackBar(context: context, text: data["message"]);
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }




}
