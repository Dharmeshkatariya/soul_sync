import 'package:get/get.dart';

import 'app_locale.dart';

AppLocale get appLocale {
  try {
    return Get.find<AppLocale>();
  } catch (e) {
    return Get.put(AppLocale.initialize());
  }
}
