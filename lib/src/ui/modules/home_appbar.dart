import 'package:flutter/material.dart';

class AppBarTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  AppBarTextButton({required this.onPressed, this.child});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: Colors.transparent,
            shadowColor: Colors.transparent));
  }
}

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
        elevation: 4,
        child: Container(
          color: theme.appBarTheme.backgroundColor,
          child: Container(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Text('Jaswanth Sai Sattenapalli',
                      style: theme.appBarTheme.titleTextStyle),
                  actions: [
                    AppBarTextButton(onPressed: () {}, child: Text('About me')),
                    AppBarTextButton(onPressed: () {}, child: Text('Works')),
                    AppBarTextButton(onPressed: () {}, child: Text('GitHub')),
                    AppBarTextButton(
                        onPressed: () {}, child: Text('Contact me'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
