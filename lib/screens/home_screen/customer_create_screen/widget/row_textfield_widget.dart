import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';
import 'package:kenz_app/screens/widget/text_field_widget.dart';


class RowTextFields extends StatelessWidget {
  const RowTextFields({
    super.key,
    required this.controller1,
    required this.controller2,
    required this.title1,
    required this.title2,
    required this.isValidate,
    this.inputType = TextInputType.text,
    this.onTap1,
    this.onTap2,
     this.isReadOnly =false,
    this.validator1,
    this.validator2
  });

  final TextEditingController controller1;
  final TextEditingController controller2;
  final String title1;
  final String title2;
  final bool isValidate;
  final bool isReadOnly;
  final TextInputType inputType;
  final void Function()? onTap1;
  final void Function()? onTap2;
  final String? Function(String?)? validator1;
  final String? Function(String?)? validator2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child:
        TextFormFieldCustom(
          controller: controller1,
          onTap:onTap1,
          hintName: title1,
          isValidate: isValidate,
          inputType: inputType,
          isReadOnly: isReadOnly,
          validator: validator1,
        )),
        kSizedW15,
        Expanded(child:
        TextFormFieldCustom(
          controller: controller2,
          hintName: title2,
          isValidate: isValidate,
          inputType: inputType,
          isReadOnly: isReadOnly,
          onTap: onTap2,
          validator: validator2,

        )),
      ],
    );
  }
}
