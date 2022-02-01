import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rapid_hyre/src/ui/elements/text.dart' as CustomText;

class WorkCard extends HookWidget {
  final String bgImageSrc;
  final String description;
  const WorkCard(
      {Key? key, required this.bgImageSrc, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final opacityController = useAnimationController(
      duration: Duration(milliseconds: 300),
    );
    final opacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(opacityController);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(2, 2),
              blurRadius: 12,
            )
          ],
          color: Colors.white),
      // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: MouseRegion(
          onEnter: (e) {
            opacityController.forward();
          },
          onExit: (e) {
            opacityController.reverse();
          },
          child: Stack(
            children: [
              Image(image: AssetImage(bgImageSrc)),
              Positioned.fill(
                  child: AnimatedBuilder(
                      animation: opacityAnimation,
                      child: Container(
                        color: Color(0xCF222222),
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: SelectableText(
                            description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      builder: (_, child) {
                        return Opacity(
                          opacity: opacityAnimation.value,
                          child: child,
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

String getImageSrc(String imageNameWithExt) {
  return 'assets/images/home/works/$imageNameWithExt';
}

class Works extends StatelessWidget {
  const Works({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final primaryColor = theme.primaryColor;
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.Text('My works',
              style: TextStyle(color: theme.textTheme.headline2?.color)),
          Container(
            // decoration: BoxDecoration(
            //     color: primaryColor.withAlpha(25),
            //     borderRadius: BorderRadius.all(Radius.circular(12))),
            margin: EdgeInsets.only(top: 16),
            child: GridView.extent(
                maxCrossAxisExtent: 600,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.81,
                padding: const EdgeInsets.symmetric(vertical: 24),
                shrinkWrap: true,
                children: [
                  WorkCard(
                    bgImageSrc: getImageSrc('cure-covid.png'),
                    description: "Connecting patients with doctors.",
                  ),
                  WorkCard(
                    bgImageSrc: getImageSrc('photo-masonry.png'),
                    description:
                        "Masonry layout of lazily loading photos created using Nuxt.js (Vue.js), CSS4 Grid.",
                  ),
                  WorkCard(
                    bgImageSrc: getImageSrc('virtual-scroll-list.png'),
                    description:
                        "A virtual scroll list created using only functional components & hooks in React.js.",
                  ),
                  WorkCard(
                    bgImageSrc: getImageSrc('find-mask.png'),
                    description:
                        "A Deep Learning based server-less REST API client.",
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
