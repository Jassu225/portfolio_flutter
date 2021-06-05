import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rapid_hyre/src/routerHandler/root/rootRouterDataAndConfig.dart';

class RootRouterDelegate extends RouterDelegate<RouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfig> {
  late final _navigatorKey = GlobalKey<NavigatorState>();
  late final RootNavigatorState rootNavigatorState;
  RootRouterDelegate({required BuildContext context}) {
    rootNavigatorState =
        Provider.of<RootNavigatorState>(context, listen: false);
  }
  get navigatorKey => _navigatorKey;

  RouteConfig get currentConfiguration => rootNavigatorState.paths.last;

  @override
  Future<void> setNewRoutePath(RouteConfig newPathConfig) async {
    final int index = rootNavigatorState.paths
        .indexWhere((pathConfig) => pathConfig.path == newPathConfig.path);
    if (index != -1) {
      rootNavigatorState.popRoutesUntil(index);
    } else {
      rootNavigatorState.pushPathConfig(newPathConfig);
    }
  }

  @override
  Widget build(BuildContext context) {
    final paths = context
        .select<RootNavigatorState, List<RouteConfig>>((state) => state.paths);
    final List<Page> pages = paths.map((pathConfig) {
      final getPageInstance = pathWidgetTypeMap[pathConfig.path]!;
      return MaterialPage(child: getPageInstance());
    }).toList();
    return Navigator(
        key: UniqueKey(),
        pages: pages,
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          rootNavigatorState.popRoute();

          return true;
        });
  }
}
