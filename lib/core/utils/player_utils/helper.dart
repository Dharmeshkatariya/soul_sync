import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../app/screen_navigation.dart';
import '../../../custom_view/player_widget/sort_widget.dart';

void printERROR(dynamic text, {String tag = "Harmony Music"}) {
  if (kReleaseMode) return;
  debugPrint("\x1B[31m[$tag]: $text\x1B[0m");
}

void printWarning(dynamic text, {String tag = 'Harmony Music'}) {
  if (kReleaseMode) return;
  debugPrint("\x1B[33m[$tag]: $text\x1B[34m");
}

void printINFO(dynamic text, {String tag = 'Harmony Music'}) {
  if (kReleaseMode) return;
  debugPrint("\x1B[32m[$tag]: $text\x1B[34m");
}

String? getCurrentRouteName() {
  String? currentPath;
  Get.nestedKey(ScreenNavigationSetup.id)?.currentState?.popUntil((route) {
    currentPath = route.settings.name;
    return true;
  });
  return currentPath;
}


/// Return true if new version available
Future<bool> newVersionCheck(String currentVersion) async {
  try {
    final tags = (await Dio().get(
      "https://api.github.com/repos/anandnet/Harmony-Music/tags",
    ))
        .data;
    final availableVersion = tags[0]['name'] as String;
    List currentVersion_ = currentVersion.substring(1).split(".");
    List availableVersion_ = availableVersion.substring(1).split(".");
    if (int.parse(availableVersion_[0]) > int.parse(currentVersion_[0])) {
      return true;
    } else if (int.parse(availableVersion_[1]) >
            int.parse(currentVersion_[1]) &&
        int.parse(availableVersion_[0]) == int.parse(currentVersion_[0])) {
      return true;
    } else if (int.parse(availableVersion_[2]) >
            int.parse(currentVersion_[2]) &&
        int.parse(availableVersion_[0]) == int.parse(currentVersion_[0]) &&
        int.parse(availableVersion_[1]) == int.parse(currentVersion_[1])) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}

String getTimeString(Duration time) {
  final minutes = time.inMinutes.remainder(Duration.minutesPerHour).toString();
  final seconds = time.inSeconds
      .remainder(Duration.secondsPerMinute)
      .toString()
      .padLeft(2, '0');
  return time.inHours > 0
      ? "${time.inHours}:${minutes.padLeft(2, "0")}:$seconds"
      : "$minutes:$seconds";
}
