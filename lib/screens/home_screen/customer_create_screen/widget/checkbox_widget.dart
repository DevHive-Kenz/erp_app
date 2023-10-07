import 'package:flutter/material.dart';

import '../../../../constants/color_manger.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/style_manager.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    super.key,
    required this.valueInCheckBox,
    required this.title,
    required this.isDisabled,
  });

  final ValueNotifier<bool> valueInCheckBox;
  final String title;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: ColorManager.white,
          activeColor: ColorManager.primaryLight,
          side: BorderSide(
              color: ColorManager.primaryLight,
              width: 2
          ),
          value: valueInCheckBox.value,
          shape: const CircleBorder(),
          onChanged:isDisabled ? null : (value) {
            valueInCheckBox.value = value ?? false;
          },
        ),
        kSizedBox4,
        Text(title,style: getBoldStyle(color:isDisabled ? ColorManager.grey4 : ColorManager.primaryLight),)
      ],
    );
  }
}
