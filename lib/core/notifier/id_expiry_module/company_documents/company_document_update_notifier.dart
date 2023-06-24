import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/company_document/documents/company_update_api.dart';
import 'company_document_list_notifier.dart';

class CompanyUpdateDocumentNotifier extends ChangeNotifier {
  final CompanyDocumentUpdateApi _updateCompanyDocumentAPI = CompanyDocumentUpdateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  Future<void> updateCompanyDocument({
    required BuildContext context,
    required String expiry,
    required String documentType,
    required String documentNumber,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;
      int? documentId = context.read<GeneralNotifier>().getSelectedDocumentID;


      final data = await _updateCompanyDocumentAPI.companyDocumentUpdateApi(
        companyID: companyID!,
        branchID: branchID!,
        documentId: documentId!,
        expiry: expiry,
        documentType: documentType,
        documentNumber: documentNumber,
      );

      if (data != null && (data["status"] == 201 || data["status"] == 200)) {
        await context.read<CompanyDocumentListNotifier>().fetchCompanyDocumentList(context: context);
      Navigator.pop(context);
        showSnackBar(
          context: context,
          text: data["message"],
          color: ColorManager.green,
        );
        
        // Additional logic or navigation can be performed here upon successful update
      } else {
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
