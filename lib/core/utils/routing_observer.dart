import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common.dart';

class RoutingObserver extends GetObserver {
  final List<Route> routeStack = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    Common().printLog(
      "GetObserver",
      'route:${route.settings.name}  previousRoute:${previousRoute?.settings.name}',
    );
    super.didPush(route, previousRoute);
    routeStack.add(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    Common().printLog(
      "GetObserver",
      'route:${route.settings.name}  previousRoute:${previousRoute?.settings.name}',
    );
    super.didPop(route, previousRoute);
    routeStack.remove(route);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    Common().printLog(
      "GetObserver",
      'route:${route.settings.name}  previousRoute:${previousRoute?.settings.name}',
    );
    super.didRemove(route, previousRoute);
    routeStack.remove(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    Common().printLog(
      "GetObserver",
      'newRoute:${newRoute?.settings.name}  oldRoute:${oldRoute?.settings.name}',
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null && newRoute != null) {
      final index = routeStack.indexOf(oldRoute);
      if (index != -1) {
        routeStack[index] = newRoute;
      }
    }
  }
}

class MiddleWare extends GetObserver {
  static observer(Routing routing) {
    print('Route Changed Observed: ${routing.current}');
  }

  @override
  void didPop(dynamic route, dynamic previousRoute) {
    print('Route Changed Observed: didPop ${route.toString()}');
    print('Route Changed Observed: didPop ${previousRoute.toString()}');
  }
}
