import 'package:flutter/material.dart';
import 'package:rapid_hyre/src/ui/container/home/home_appbar.dart';
import 'package:rapid_hyre/src/ui/container/home/landing_section.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print('home page');
    final theme = Theme.of(context);
    return Scaffold(
      appBar: HomePageAppBar(),
      body: ListView(
        children: [
          LandingSection(),
          Container(
            margin: EdgeInsets.only(top: 40, bottom: 32, left: 80, right: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About Me',
                    style: theme.textTheme.headline3
                        ?.copyWith(color: theme.textTheme.headline2?.color),
                    textAlign: TextAlign.start),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //     topRight: Radius.circular(8),
                      //     bottomRight: Radius.circular(8)),
                      border: Border(
                        left: BorderSide(
                          color: theme.primaryColor,
                          width: 6,
                        ),
                      ),
                      color: theme.primaryColor.withAlpha(25)),
                  child: Text(
                    'I am an experienced Software Engineer with 3+ years of experience in the web development. I have professional experience in several technologies such as Next.js, React.js, Redux, Vue.js and many more. I love playing video games, watching Nextflix, solving problems (web related) and learning new technologies. Currently, I am learning dart and flutter.',
                    style: theme.textTheme.headline6?.copyWith(height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
