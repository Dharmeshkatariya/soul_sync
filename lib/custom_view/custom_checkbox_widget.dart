import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/color_file.dart';

class CustomCheckboxWidget extends StatelessWidget {
  final RxBool checkboxValue;
  final ValueChanged<bool> onChangedCallBack;
  final bool enabled;
  final OutlinedBorder? shape;

  const CustomCheckboxWidget({
    super.key,
    required this.checkboxValue,
    required this.onChangedCallBack,
    this.shape,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Checkbox(
        shape:
            shape ??
            RoundedRectangleBorder(
              side: BorderSide(color: ColorFile.xfE1E4EA, width: 1),
            ),
        checkColor: Colors.white,
        activeColor: ColorFile.webThemeColor,
        value: checkboxValue.value,
        onChanged:
            enabled
                ? (bool? value) {
                  onChangedCallBack(value!);
                }
                : null,
      ),
    );
  }
}
