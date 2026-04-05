import 'package:flutter/material.dart';

class MoreMenuItemModel {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final GlobalKey? globalKey;

  MoreMenuItemModel({
    required this.title,
    this.globalKey,
    required this.iconPath,
    required this.onTap,
  });
}
