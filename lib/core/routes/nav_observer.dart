import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavObserver extends GetObserver {
  @override
  void didPop(Route? route, Route? previousRoute) {}

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {}

  @override
  void didRemove(Route? route, Route? previousRoute) {}

  @override
  void didPush(Route? route, Route? previousRoute) {}
}
