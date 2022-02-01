import 'package:flutter/material.dart';
import 'package:rapid_hyre/src/ui/elements/text.dart' as CustomText;

class AboutMe extends StatelessWidget {
  const AboutMe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 0, bottom: 32, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.Text(
            'About me',
            style: TextStyle(color: theme.textTheme.headline2?.color),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 40),
            margin: EdgeInsets.only(top: 16),
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
            child: SelectableText(
              'I am an experienced Software Engineer with 3+ years of experience in the web development. I have professional experience in several technologies such as Next.js, React.js, Redux, Vue.js and many more. I love playing video games, watching Nextflix, solving problems (web related) and learning new technologies. Currently, I am learning dart and flutter.',
              style: theme.textTheme.headline6?.copyWith(height: 1.5),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
