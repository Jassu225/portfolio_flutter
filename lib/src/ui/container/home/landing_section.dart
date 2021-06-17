import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FadeInMoveUpWidget extends StatelessWidget {
  final AnimationController controller;
  final double intervalBegin;
  final double intervalEnd;
  final Widget child;
  final double height;

  late final Animation<double> _opacity;
  late final Animation<Offset> _position;

  FadeInMoveUpWidget(
      {Key? key,
      required this.controller,
      required this.intervalBegin,
      required this.intervalEnd,
      required this.child,
      required this.height})
      : super(key: key) {
    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(intervalBegin, intervalEnd, curve: Curves.easeOut)));

    _position = Tween<Offset>(begin: const Offset(0, 0.75), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: controller,
            curve:
                Interval(intervalBegin, intervalEnd, curve: Curves.easeOut)));
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _position,
        child:
            Container(child: FadeTransition(opacity: _opacity, child: child)));
  }
}

class _LandingSectionContent extends StatelessWidget {
  final AnimationController controller;
  _LandingSectionContent({required this.controller});

  @override
  Widget build(BuildContext context) {
    // print('build landing_section content');
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final headline4Theme =
        textTheme.headline4?.copyWith(fontWeight: FontWeight.normal);
    final headline2Theme = textTheme.headline2;
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        // print('animated build landing_section content');
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInMoveUpWidget(
                child: Text('Hello World!', style: headline4Theme),
                height: 50,
                controller: controller,
                intervalBegin: 0,
                intervalEnd: 0.3),
            const SizedBox(height: 8),
            FadeInMoveUpWidget(
                height: 100,
                child: Row(
                  children: [
                    Text('I\'m ', style: headline2Theme),
                    Text('Jaswanth',
                        style: headline2Theme?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w600))
                  ],
                ),
                controller: controller,
                intervalBegin: 0.35,
                intervalEnd: 0.65),
            FadeInMoveUpWidget(
                height: 100,
                child: Text(
                  'A web enthusiast',
                  style: headline2Theme,
                ),
                controller: controller,
                intervalBegin: 0.7,
                intervalEnd: 1)
          ],
        );
      },
    );
  }
}

class _AnimatedLandingSectionContent extends StatefulWidget {
  const _AnimatedLandingSectionContent({Key? key}) : super(key: key);

  @override
  _AnimatedLandingSectionContentState createState() =>
      _AnimatedLandingSectionContentState();
}

class _AnimatedLandingSectionContentState
    extends State<_AnimatedLandingSectionContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2000));

  void _playAnimation() async {
    new Timer(const Duration(milliseconds: 500), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void initState() {
    super.initState();
    // _controller.forward();
    // print("start animation");
    _playAnimation();
  }

  @override
  Widget build(BuildContext context) {
    // print("build AnimatedBuilder");
    return _LandingSectionContent(controller: _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    // print("dispose");
    super.dispose();
  }
}

class LandingSection extends StatelessWidget {
  const LandingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('landing section');
    // final sectionContentWidth = _getContentContainerWidth(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // margin: EdgeInsets.only(right: 60),
            child: _AnimatedLandingSectionContent(),
          ),
          Container(
              child: Lottie.asset('assets/lottie/developer.json',
                  animate: true,
                  repeat: true,
                  reverse: true,
                  width: 400,
                  height: 400)),
        ],
      ),
    );
  }
}
