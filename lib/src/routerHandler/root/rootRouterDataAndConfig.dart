import 'package:flutter/material.dart';
import 'package:rapid_hyre/src/ui/pages/home/home.dart';

// #region generic-logic
// class PathType {
//   final String path;
//   final Function getPageInstance;
//   PathType({required this.path, required this.getPageInstance});
// }

// const routeNamePathMap = {'home': '/'};

class RootRouteNamePathMap {
  const RootRouteNamePathMap._internal();
  const factory RootRouteNamePathMap() = RootRouteNamePathMap._internal;

  String get home => '/';
}

const routeNamePathMap = RootRouteNamePathMap();

final Map<String, Widget Function()> pathWidgetTypeMap = {
  routeNamePathMap.home: () => HomePage()
};

class RouteConfig {
  final String path;
  late final Map<String, String> query;
  late final String asPath;
  late final String url;

  final RegExp _regExp = RegExp(r'^\[([a-zA-Z0-9_]+)\]$');

  RouteConfig({required this.path, Map<String, String>? query}) {
    this.query = query != null ? query : {};
    url = _getUrl(path, this.query);
    asPath = _getAsPath(path, this.query);
  }

  String _getQueryString(Map<String, String> query) {
    final List<String> queryList = [];
    if (query.isNotEmpty) {
      query.forEach((key, value) {
        queryList.add('$key=$value');
      });
    }
    return queryList.length > 0 ? '?${queryList.join('&')}' : '';
  }

  String _getAsPath(String path, Map<String, String> query) =>
      '$path${_getQueryString(query)}';

  String _getUrl(String path, Map<String, String> query) {
    final uri = Uri.parse(path);
    final queryMap = {...query};
    print(uri.path);
    String url = uri.pathSegments.map((segment) {
      final match = _regExp.firstMatch(segment);
      if (match != null) {
        final key = match.group(1);
        if (key != null && queryMap[key] != null) {
          final value = queryMap[key];
          queryMap.remove(key);
          return value;
        }
      }
      return segment;
    }).join('/');
    return '$url${_getQueryString(queryMap)}';
  }
}
// #endregion

class RootNavigatorState extends ChangeNotifier {
  late final _pathsList = <RouteConfig>[
    // RouteConfig(path: routeNamePathMap.home)
  ];

  List<RouteConfig> get paths => _pathsList;

  void pushRoute(String path, Map<String, String> query) {
    _pathsList.add(RouteConfig(path: path, query: query));
    notifyListeners();
  }

  void popRoute() {
    if (_pathsList.isNotEmpty) {
      _pathsList.removeLast();
      notifyListeners();
    }
  }

  void popRoutesUntil(int index) {
    _pathsList.sublist(0, index + 1);
    notifyListeners();
  }

  void pushPathConfig(RouteConfig pathConfig) {
    _pathsList.add(pathConfig);
    notifyListeners();
  }
}

class RootRouteInformationParser extends RouteInformationParser<RouteConfig> {
  @override
  Future<RouteConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    final location = routeInformation.location ?? routeNamePathMap.home;
    final uri = Uri.parse(location);
    return RouteConfig(path: location, query: uri.queryParameters);
  }

  @override
  RouteInformation restoreRouteInformation(RouteConfig routeConfig) {
    return RouteInformation(location: routeConfig.asPath);
  }
}
