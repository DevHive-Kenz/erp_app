import 'package:json_annotation/json_annotation.dart';


part 'profile_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileResultModel {
  final int? id;
  @JsonKey(name: "user_id") final int? userId;
  @JsonKey(name: "about_company") final String? aboutCompany;
  final String? mobile;
  final String? location;
  @JsonKey(name: "company_logo") final String? companyLogo;
  @JsonKey(name: "company_name") final String? companyName;
  @JsonKey(name: "company_name_arabic") final String? companyNameArabic;
  @JsonKey(name: "company_address_1") final String? companyAddress1;
  @JsonKey(name: "company_address_1_arabic") final String? companyAddress1Arabic;
  @JsonKey(name: "company_address_2") final String? companyAddress2;
  @JsonKey(name: "company_address_2_arabic") final String? companyAddress2Arabic;
  @JsonKey(name: "company_crn") final String? companyCrn;
  @JsonKey(name: "company_vat") final String? companyVat;
  @JsonKey(name: "account_name") final String? accountName;
  @JsonKey(name: "account_name_arabic") final String? accountNameArabic;
  @JsonKey(name: "bank_name") final String? bankName;
  @JsonKey(name: "bank_name_arabic") final String? bankNameArabic;
  @JsonKey(name: "account_number") final String? accountNumber;
  @JsonKey(name: "iban") final String? iban;
  @JsonKey(name: "bank_branch") final String? bankBranch;
  @JsonKey(name: "bank_branch_arabic") final String? bankBranchArabic;
  @JsonKey(name: "web") final String? web;
  @JsonKey(name: "mail") final String? mail;
  @JsonKey(name: "tele") final String? tele;
  @JsonKey(name: "sale_start_number") final int? saleStartNumber;
  @JsonKey(name: "quotation_start_number") final int? quotationStartNumber;
  @JsonKey(name: "purchase_start_number") final int? purchaseStartNumber;
  @JsonKey(name: "delivery_start_number") final int? deliveryStartNumber;
  @JsonKey(name: "company_sale_prefix") final String? companySalePrefix;
  @JsonKey(name: "company_purchase_order_prefix") final String? companyPurchaseOrderPrefix;
  @JsonKey(name: "company_purchase_prefix") final String? companyPurchasePrefix;
  @JsonKey(name: "company_purchase_return_prefix") final String? companyPurchaseReturnPrefix;
  @JsonKey(name: "company_quotation_prefix") final String? companyQuotationPrefix;
  @JsonKey(name: "company_sale_return_prefix") final String? companySaleReturnPrefix;
  @JsonKey(name: "company_delivery_note_prefix") final String? companyDeliveryNotePrefix;
  @JsonKey(name: "zero_pad") final int? zeroPad;
  @JsonKey(name: "logo_in_pos") final bool? logoInPos;
  @JsonKey(name: "pdf_header") final String? pdfHeader;
  @JsonKey(name: "pdf_footer") final String? pdfFooter;
  ProfileResultModel(
      {this.id,
      this.userId,
      this.aboutCompany,
      this.mobile,
      this.location,
      this.companyLogo,
      this.companyName,
      this.companyNameArabic,
      this.companyAddress1,
      this.companyAddress1Arabic,
      this.companyAddress2,
      this.companyAddress2Arabic,
      this.companyCrn,
      this.companyVat,
      this.accountName,
      this.accountNameArabic,
      this.bankName,
      this.bankNameArabic,
      this.accountNumber,
      this.iban,
      this.bankBranch,
      this.bankBranchArabic,
      this.web,
      this.mail,
      this.tele,
      this.saleStartNumber,
      this.quotationStartNumber,
      this.purchaseStartNumber,
      this.deliveryStartNumber,
      this.companySalePrefix,
      this.companyPurchaseOrderPrefix,
      this.companyPurchasePrefix,
      this.companyPurchaseReturnPrefix,
      this.companyQuotationPrefix,
      this.companySaleReturnPrefix,
      this.companyDeliveryNotePrefix,
      this.zeroPad,
      this.logoInPos,
      this.pdfHeader,
      this.pdfFooter,
      });


  factory ProfileResultModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResultModelToJson(this);
}
