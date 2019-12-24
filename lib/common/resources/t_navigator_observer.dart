part of petisland.common.resources;

class TNavigatorObserver extends NavigatorObserver {
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    // Log.debug('$runtimeType didPush route: $route previousRoute: $previousRoute');
  }

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    // Log.debug('$runtimeType didPop $route previousRoute: $previousRoute');
  }
}
