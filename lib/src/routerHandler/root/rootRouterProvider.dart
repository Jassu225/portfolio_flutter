import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_hyre/src/routerHandler/root/rootRouterDataAndConfig.dart';

class RootRouterProvider extends StatelessWidget {
  final Widget child;
  RootRouterProvider({required this.child});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RootNavigatorState(),
      child: child,
    );
  }
}
