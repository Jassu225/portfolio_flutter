import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rapid_hyre/src/routerHandler/route_config.dart';
import 'package:rapid_hyre/src/ui/pages/home.dart';

class RootRouteNamePathMap {
  const RootRouteNamePathMap._internal();
  const factory RootRouteNamePathMap() = RootRouteNamePathMap._internal;

  String get home => '/';
}

const routeNamePathMap = RootRouteNamePathMap();

final Map<String, Widget Function()> pathWidgetTypeMap = {
  routeNamePathMap.home: () => HomePage()
};

class _RootPagesNotifier extends StateNotifier<List<RouteConfig>> {
  _RootPagesNotifier() : super([RouteConfig(path: routeNamePathMap.home)]);

  // void pushRouteX(String path, Map<String, String> query) {
  //   state.add(RouteConfig(path: path, query: query));
  // }

  void pushRoute(RouteConfig pathConfig) {
    state = [...state, pathConfig];
  }

  void popRoute() {
    if (state.isNotEmpty) {
      state.removeLast();
    }
  }

  void popRoutesUntil(int index) {
    state.sublist(0, index + 1);
  }
}

final rootPagesProvider =
    StateNotifierProvider<_RootPagesNotifier, List<RouteConfig>>((ref) {
  return _RootPagesNotifier();
});

class RootRouteInformationParser extends RouteInformationParser<RouteConfig> {
  @override
  Future<RouteConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    print('parse route - ${routeInformation.location}');
    if (routeInformation.location == null) return RouteConfig(path: '');
    final location = routeInformation.location!;
    final uri = Uri.parse(location);
    return RouteConfig(path: location, query: uri.queryParameters);
  }

  @override
  RouteInformation restoreRouteInformation(RouteConfig routeConfig) {
    print('restore route - ${routeConfig.asPath}');
    return RouteInformation(location: routeConfig.asPath);
  }
}
