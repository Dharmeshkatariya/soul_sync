import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProceedButton extends StatelessWidget {
  const ProceedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });
  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.titleLarge!.color,
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: CustomTextView(
            buttonText,
            style: TextStyle(color: Theme.of(context).canvasColor),
          ),
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomTextView("cancel".tr),
      ),
      onTap: () {
        Navigator.of(context).pop();
         if (onPressed != null) {
          onPressed!();
        }
      },
    );
  }
}
