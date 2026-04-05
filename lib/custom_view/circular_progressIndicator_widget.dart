import 'package:flutter/material.dart';

import '../core/utils/color_file.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorFile.webThemeColor,
      ),
    );
  }
}
