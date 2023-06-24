import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/company_document/documents/company_delete_api.dart';
import 'company_document_list_notifier.dart';

class CompanyDocumentDeleteNotifier extends ChangeNotifier {
  final CompanyDocumentDeleteApi _deleteCompanyDocumentAPI = CompanyDocumentDeleteApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;

  int? get getStatusCode => _statusCode;

  Future<void> deleteCompanyDocument({
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;
      int? documentId = context.read<GeneralNotifier>().getSelectedDocumentID;


      final data = await _deleteCompanyDocumentAPI.companyDocumentDeleteApi(
        companyID: companyID!,
        branchID: branchID!,
        documentId: documentId!,
      );

      if (data != null && (data["status"] == 201 || data["status"] == 200)) {
        await context.read<CompanyDocumentListNotifier>().fetchCompanyDocumentList(context: context);
        Navigator.pop(context);

        // Success
        showSnackBar(
          context: context,
          text: data["message"],
          color: ColorManager.green,
        );
      } else {
        // Error
        showSnackBar(
          context: context,
          text: "Failed to delete document",
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      // Error handling
      _isLoading = false;
      notifyListeners();

      showSnackBar(
        context: context,
        text: "An error occurred",
      );
    }
  }

}