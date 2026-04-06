import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../app/screen_navigation.dart';


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
