import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rapid_hyre/src/ui/elements/text.dart' as CustomText;

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
        curve: Interval(intervalBegin, intervalEnd, curve: Curves.easeInOut)));

    _position = Tween<Offset>(begin: const Offset(0, 0.75), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: controller,
            curve:
                Interval(intervalBegin, intervalEnd, curve: Curves.easeInOut)));
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
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        // print('animated build landing_section content');
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: size.width > 800
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            FadeInMoveUpWidget(
              child: CustomText.Text('Hello World!',
                  variant: CustomText.Variant.H4,
                  style: TextStyle(fontWeight: FontWeight.normal)),
              height: 50,
              controller: controller,
              intervalBegin: 0,
              intervalEnd: 0.3,
            ),
            const SizedBox(height: 8),
            FadeInMoveUpWidget(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.Text('I\'m '),
                    CustomText.Text('Jaswanth',
                        style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w600))
                  ],
                ),
                controller: controller,
                intervalBegin: 0.35,
                intervalEnd: 0.65),
            FadeInMoveUpWidget(
                height: 100,
                child: CustomText.Text('A web enthusiast'),
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
    final children = [
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
    ];
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: size.width > 800
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            )
          : Column(
              children: children,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
    );
  }
}
