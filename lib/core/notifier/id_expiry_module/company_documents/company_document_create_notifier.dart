import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/company_document/documents/company_create_api.dart';
import 'company_document_list_notifier.dart';




class CompanyCreateDocumentNotifier extends ChangeNotifier {
  final CompanyDocumentCreateApi _createCompanyDocumentAPI = CompanyDocumentCreateApi();

  bool _isLoading = false;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  int? get getStatusCode => _statusCode;

  Future<void> postCompanyDocument({
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

      final data   = await _createCompanyDocumentAPI.companyDocumentCreateApi(companyID: companyID!, branchID: branchID!, expiry: expiry, documentType: documentType, documentNumber: documentNumber);
      if(data["status"] == 200 || data["status"] == 201){
        await context.read<CompanyDocumentListNotifier>().fetchCompanyDocumentList(context: context);
        showSnackBar(context: context, text: data["message"],color: ColorManager.green);

        // Navigator.pushReplacementNamed(context, mainRoute);
      }else{
        showSnackBar(context: context, text: data["message"]);
      }
      _isLoading = false;
      notifyListeners();
    } catch(error){
      showSnackBar(
        context: context,
        text: "An error occurred",
      );
      _isLoading = false;
      notifyListeners();
    }
  }
}