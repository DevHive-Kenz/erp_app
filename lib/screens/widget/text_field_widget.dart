import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


import '../../../constants/color_manger.dart';
import '../../../constants/style_manager.dart';
import '../../../constants/values_manger.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String? hintName;
  final IconData? icon;
  final bool isObscureText;
  final bool isValidate;
  final int? maxLength,maxLine;
  final TextInputType inputType;
  final bool isEnable, isEditable, isReadOnly;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final double paddingWidth;
  final FocusNode? focus;



  const TextFormFieldCustom(
      {required this.controller,
        this.hintName,
        this.icon,
        this.onChanged,
        this.validator,
        this.isEditable = true,
        this.maxLength,
        this.maxLine,
        this.inputFormatters,
        this.isObscureText = false,
        this.isValidate = true,
        this.inputType = TextInputType.text,
        this.isEnable = true,
        this.onTap,
        this.isReadOnly = false,
        this.paddingWidth = AppPadding.p20,this.focus,

        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        readOnly: isReadOnly,

        onTap: onTap,
        enabled: isEnable,
        style: getSemiBoldStyle(color:ColorManager.black),
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: isValidate ? validator ??
                (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $hintName';
              }
              return null;
            }:null,
        onChanged:  onChanged,
        maxLines: maxLine,
        focusNode: focus,

        autocorrect: isEditable,
        enableSuggestions: isEditable,
        enableInteractiveSelection: isEditable,
        maxLength: maxLength,
        decoration: InputDecoration(
          errorMaxLines: 3,
          contentPadding: EdgeInsets.symmetric( horizontal: AppPadding.p16),
          floatingLabelStyle: getSemiBoldStyle(color:ColorManager.primaryLight ),
          enabledBorder: OutlineInputBorder(
            borderRadius:const BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color:ColorManager.primaryLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:const  BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color:ColorManager.primaryLight),
          ),
          prefixIcon: icon!=null ? Icon(
            icon,
            color: ColorManager.primaryLight ,
          ):null,

          // hintText: hintName,
          labelText: hintName,
          labelStyle: getBoldStyle(color:ColorManager.primaryLight),
          fillColor: ColorManager.white ,
          filled: true,
        ),
      ),
    );
  }
}