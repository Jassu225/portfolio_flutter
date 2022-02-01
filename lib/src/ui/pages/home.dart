import 'package:flutter/material.dart';
import 'package:rapid_hyre/src/ui/container/home/about_me.dart';
import 'package:rapid_hyre/src/ui/container/home/works/works.dart';
import 'package:rapid_hyre/src/ui/modules/home_appbar.dart';
import 'package:rapid_hyre/src/ui/container/home/landing_section.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print('home page');
    // final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: HomePageAppBar(),
      body: SingleChildScrollView(
        child: Container(
          // decoration: BoxDecoration(color: primaryColor),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: Column(
                children: const [LandingSection(), AboutMe(), Works()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
