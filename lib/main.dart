import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rapid_hyre/src/routerHandler/root/rootRouterDataAndConfig.dart';
import 'package:rapid_hyre/src/routerHandler/root/rootRouterDelegate.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

// const primaryColor = const Color(0xFF6200EE);
const primaryColor = const Color(0xFF4C7DF6);
// const textColor = Color.fromRGBO(55, 58, 60, 1);
const textColor = Color(0xFF3C4852);

void main() {
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("main");
    return ChangeNotifierProvider(
      create: (_) => RootNavigatorState(),
      builder: (context, _) => MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: primaryColor,
          primarySwatch: MaterialColor(primaryColor.value, <int, Color>{
            50: const Color(0xe5f4ff),
            100: const Color(0xc2e2ff),
            200: const Color(0x9ad1ff),
            300: const Color(0x72beff),
            400: const Color(0x59aeff),
            500: const Color(0X4c9fff),
            600: const Color(0x4d90ff),
            700: primaryColor,
            800: const Color(0x4b6ae3),
            900: const Color(0x4748c2)
          }),
          textTheme: const TextTheme(
              headline2: TextStyle(color: textColor),
              headline4: TextStyle(color: textColor)),
        ),
        themeMode: ThemeMode.light,
        routeInformationParser: RootRouteInformationParser(),
        routerDelegate: RootRouterDelegate(context: context),
      ),
    );
  }
}
