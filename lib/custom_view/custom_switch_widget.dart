import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../core/utils/color_file.dart';

class CustomSwitchWidget extends StatelessWidget {
  final RxBool switchValue;
  final ValueChanged<bool> onChangedCallBack;
  Color? activeColor;
  bool enabled;

  CustomSwitchWidget({
    required this.switchValue,
    required this.onChangedCallBack,
    super.key,
    this.activeColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    activeColor ??= ColorFile.webThemeColor;
    return SizedBox(
      width: 40,
      height: 24,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Obx(
          () => CupertinoSwitch(
            value: switchValue.value,
            onChanged:
                (enabled)
                    ? (value) {
                      onChangedCallBack(value);
                    }
                    : null,
            activeColor: activeColor,
          ),
        ),
      ),
    );
  }
}
