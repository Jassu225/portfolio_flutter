import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rapid_hyre/src/routerHandler/root/rootRouterDataAndConfig.dart';
import 'package:rapid_hyre/src/routerHandler/route_config.dart';

class RootRouterDelegate extends RouterDelegate<RouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfig> {
  late final _navigatorKey = GlobalKey<NavigatorState>();
  final Reader read;
  RootRouterDelegate({required this.read});

  get navigatorKey => _navigatorKey;

  RouteConfig get currentConfiguration => read(rootPagesProvider).last;

  @override
  Future<void> setNewRoutePath(RouteConfig newPathConfig) async {
    final paths = read(rootPagesProvider);
    final notifier = read(rootPagesProvider.notifier);
    final int index =
        paths.indexWhere((pathConfig) => pathConfig.path == newPathConfig.path);
    if (index != -1) {
      notifier.popRoutesUntil(index);
    } else {
      notifier.pushRoute(newPathConfig);
    }
  }

  @override
  Widget build(BuildContext context) {
    final paths = read(rootPagesProvider);
    final List<Page> pages = paths.map((pathConfig) {
      final getPageInstance = pathWidgetTypeMap[pathConfig.path]!;
      return MaterialPage(
          child: getPageInstance(), key: ValueKey(pathConfig.asPath));
    }).toList();
    print('router delegate build -- ${paths.map((e) => e.asPath)}');
    return Navigator(
        key: UniqueKey(),
        pages: pages,
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          read(rootPagesProvider.notifier).popRoute();
          return true;
        });
  }
}
