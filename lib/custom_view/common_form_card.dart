import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_sync/core/utils/common_widget.dart';

import 'border_container.dart';

class CommonFormCard extends StatelessWidget {
  const CommonFormCard({
    super.key,
    required this.title,
    required this.child,
    this.width,
    this.padding,
    this.isAddedHeight = true,
    this.constraints,
    this.verticalSubWidget,
  });

  final String title;
  final Widget child;
  final double? width;
  final bool isAddedHeight;
  final BoxConstraints? constraints;

  final EdgeInsetsGeometry? padding;
  final Widget? verticalSubWidget;

  @override
  Widget build(BuildContext context) {
    return _formCard();
  }

  static BorderRadius _commonBorderRadius() {
    return BorderRadius.all(Radius.circular(10.r));
  }

  Widget _formCard() {
    return BorderContainer(
      constraints: constraints,
      borderRadius: _commonBorderRadius(),
      width: width ?? double.infinity,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget.cardTitleWidget(
            title: title,
            verticalSubWidget: verticalSubWidget,
          ),
          if (isAddedHeight) ...[SizedBox(height: 20.h)],
          Padding(padding: padding ?? _commonPadding(), child: child),
          if (isAddedHeight) ...[SizedBox(height: 5.h), SizedBox(height: 20.h)],
        ],
      ),
    );
  }

  EdgeInsets _commonPadding() {
    return EdgeInsets.symmetric(horizontal: 20.w);
  }
}
