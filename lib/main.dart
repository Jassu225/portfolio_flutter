import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rapid_hyre/src/routerHandler/root/rootRouterDataAndConfig.dart';
import 'package:rapid_hyre/src/routerHandler/root/rootRouterDelegate.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

// const primaryColor = const Color(0xFF6200EE);
const primaryColor = const Color(0xFF4C7DF6);
// const primaryColor = const Color(0xFF0a1929);
// const textColor = Color.fromRGBO(55, 58, 60, 1);
const textColor = Color(0xFF3C4852);

void main() {
  configureApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("main");
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        primarySwatch: MaterialColor(primaryColor.value, <int, Color>{
          50: const Color(0xffe5f4ff),
          100: const Color(0xffc2e2ff),
          200: const Color(0xff9ad1ff),
          300: const Color(0xff72beff),
          400: const Color(0xff59aeff),
          500: const Color(0Xff4c9fff),
          600: const Color(0xff4d90ff),
          700: primaryColor,
          800: const Color(0xff4b6ae3),
          900: const Color(0xff4748c2)
          // 50: const Color(0xe4f1f6),
          // 100: const Color(0xbedcea),
          // 200: const Color(0x98c6dd),
          // 300: const Color(0x76afce),
          // 400: const Color(0x5f9fc6),
          // 500: const Color(0x4c90be),
          // 600: const Color(0x4184b2),
          // 700: const Color(0x3673a1),
          // 800: const Color(0x2e638f),
          // 900: primaryColor
        }),
        appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
        textTheme: const TextTheme(
            headline2: TextStyle(color: textColor),
            headline4: TextStyle(color: textColor)),
      ),
      themeMode: ThemeMode.dark,
      routeInformationParser: RootRouteInformationParser(),
      routerDelegate: RootRouterDelegate(read: ref.read),
    );
  }
}
