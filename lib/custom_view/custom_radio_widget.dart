import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/color_file.dart';

class CustomRadioWidget extends StatelessWidget {
  final String radioValue;
  final RxString radioGroupValue;
  final ValueChanged<String> onChangedCallBack;

  const CustomRadioWidget(
    this.radioValue,
    this.radioGroupValue,
    this.onChangedCallBack, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Radio(
        value: radioValue,
        activeColor: ColorFile.webThemeColor,
        groupValue: radioGroupValue.value,
        onChanged: (value) {
          onChangedCallBack(value.toString());
        },
      ),
    );
  }
}
