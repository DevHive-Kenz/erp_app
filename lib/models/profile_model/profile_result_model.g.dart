// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResultModel _$ProfileResultModelFromJson(Map<String, dynamic> json) =>
    ProfileResultModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      aboutCompany: json['about_company'] as String?,
      mobile: json['mobile'] as String?,
      location: json['location'] as String?,
      companyLogo: json['company_logo'] as String?,
      companyName: json['company_name'] as String?,
      companyNameArabic: json['company_name_arabic'] as String?,
      companyAddress1: json['company_address_1'] as String?,
      companyAddress1Arabic: json['company_address_1_arabic'] as String?,
      companyAddress2: json['company_address_2'] as String?,
      companyAddress2Arabic: json['company_address_2_arabic'] as String?,
      companyCrn: json['company_crn'] as String?,
      companyVat: json['company_vat'] as String?,
      accountName: json['account_name'] as String?,
      accountNameArabic: json['account_name_arabic'] as String?,
      bankName: json['bank_name'] as String?,
      bankNameArabic: json['bank_name_arabic'] as String?,
      accountNumber: json['account_number'] as String?,
      iban: json['iban'] as String?,
      bankBranch: json['bank_branch'] as String?,
      bankBranchArabic: json['bank_branch_arabic'] as String?,
      web: json['web'] as String?,
      mail: json['mail'] as String?,
      tele: json['tele'] as String?,
      saleStartNumber: json['sale_start_number'] as int?,
      quotationStartNumber: json['quotation_start_number'] as int?,
      purchaseStartNumber: json['purchase_start_number'] as int?,
      deliveryStartNumber: json['delivery_start_number'] as int?,
      companySalePrefix: json['company_sale_prefix'] as String?,
      companyPurchaseOrderPrefix:
          json['company_purchase_order_prefix'] as String?,
      companyPurchasePrefix: json['company_purchase_prefix'] as String?,
      companyPurchaseReturnPrefix:
          json['company_purchase_return_prefix'] as String?,
      companyQuotationPrefix: json['company_quotation_prefix'] as String?,
      companySaleReturnPrefix: json['company_sale_return_prefix'] as String?,
      companyDeliveryNotePrefix:
          json['company_delivery_note_prefix'] as String?,
      zeroPad: json['zero_pad'] as int?,
      logoInPos: json['logo_in_pos'] as bool?,
      pdfHeader: json['pdf_header'] as String?,
      pdfFooter: json['pdf_footer'] as String?,
    );

Map<String, dynamic> _$ProfileResultModelToJson(ProfileResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'about_company': instance.aboutCompany,
      'mobile': instance.mobile,
      'location': instance.location,
      'company_logo': instance.companyLogo,
      'company_name': instance.companyName,
      'company_name_arabic': instance.companyNameArabic,
      'company_address_1': instance.companyAddress1,
      'company_address_1_arabic': instance.companyAddress1Arabic,
      'company_address_2': instance.companyAddress2,
      'company_address_2_arabic': instance.companyAddress2Arabic,
      'company_crn': instance.companyCrn,
      'company_vat': instance.companyVat,
      'account_name': instance.accountName,
      'account_name_arabic': instance.accountNameArabic,
      'bank_name': instance.bankName,
      'bank_name_arabic': instance.bankNameArabic,
      'account_number': instance.accountNumber,
      'iban': instance.iban,
      'bank_branch': instance.bankBranch,
      'bank_branch_arabic': instance.bankBranchArabic,
      'web': instance.web,
      'mail': instance.mail,
      'tele': instance.tele,
      'sale_start_number': instance.saleStartNumber,
      'quotation_start_number': instance.quotationStartNumber,
      'purchase_start_number': instance.purchaseStartNumber,
      'delivery_start_number': instance.deliveryStartNumber,
      'company_sale_prefix': instance.companySalePrefix,
      'company_purchase_order_prefix': instance.companyPurchaseOrderPrefix,
      'company_purchase_prefix': instance.companyPurchasePrefix,
      'company_purchase_return_prefix': instance.companyPurchaseReturnPrefix,
      'company_quotation_prefix': instance.companyQuotationPrefix,
      'company_sale_return_prefix': instance.companySaleReturnPrefix,
      'company_delivery_note_prefix': instance.companyDeliveryNotePrefix,
      'zero_pad': instance.zeroPad,
      'logo_in_pos': instance.logoInPos,
      'pdf_header': instance.pdfHeader,
      'pdf_footer': instance.pdfFooter,
    };
