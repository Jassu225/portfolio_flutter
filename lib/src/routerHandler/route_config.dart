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

  /// Gives the query string
  ///
  /// E.g. `?key1=value1&key2=value2`
  String _getQueryString(Map<String, String> query) {
    final List<String> queryList = [];
    if (query.isNotEmpty) {
      query.forEach((key, value) {
        queryList.add('$key=$value');
      });
    }
    return queryList.length > 0 ? '?${queryList.join('&')}' : '';
  }

  /// Gives path with query string
  ///
  /// E.g. `/book/\[bookID\]/?bookID=1&key=value`
  String _getAsPath(String path, Map<String, String> query) =>
      '$path${_getQueryString(query)}';

  String _getUrl(String path, Map<String, String> query) {
    final uri = Uri.parse(path);
    final queryMap = {...query};
    // print(uri.path);
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
