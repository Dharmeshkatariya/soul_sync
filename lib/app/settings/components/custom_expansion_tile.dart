import 'package:soul_sync/core/extension/text_style.dart';
import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const CustomExpansionTile({
    super.key,
    required this.children,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        childrenPadding: const EdgeInsets.all(8),
        tilePadding: const EdgeInsets.only(right: 16, left: 10),
        textColor: context.titleMedium!.color,
        iconColor: context.titleMedium!.color,
        collapsedBackgroundColor: Theme.of(
          context,
        ).colorScheme.secondary.withAlpha(30),
        backgroundColor: Theme.of(context).colorScheme.secondary.withAlpha(30),
        title: CustomTextView(title),
        leading: Icon(icon),
        children: children,
      ),
    );
  }
}
