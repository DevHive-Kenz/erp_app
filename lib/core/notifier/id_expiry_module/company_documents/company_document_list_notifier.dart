import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../models/id_expiry_module/company_document/company_document_list_model/company_document_list_model.dart';
import '../../../../provider/general_notifier.dart';
import '../../../api/id_expiry_module/company_document/documents/company_list_api.dart';

class CompanyDocumentListNotifier extends ChangeNotifier {
  final CompanyDocumentList _companyDocumentListAPI = CompanyDocumentList();

  bool _isLoading = false;
  CompanyDocumentListModel? _documents;
  int? _statusCode;

  bool get getIsLoading => _isLoading;
  CompanyDocumentListModel? get getDocuments => _documents;
  int? get statusCode => _statusCode;

  Future<void> fetchCompanyDocumentList({
    required BuildContext context,

  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      int? companyID = context.read<GeneralNotifier>().getSelectedCompanyID;
      int? branchID = context.read<GeneralNotifier>().getSelectedBranchID;

      final data = await _companyDocumentListAPI.companyDocumentList(
        companyID: companyID!,
        branchID: branchID!,
      );
       _statusCode = data["status"];
      if(_statusCode == 200){
      _documents =  CompanyDocumentListModel.fromJson(data);
       notifyListeners();
        // Navigator.pushReplacementNamed(context, mainRoute);
      }else{
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
