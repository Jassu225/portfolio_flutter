import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Variant { H1, H2, H3, H4, H5, H6 }

enum TitleSize { LARGE, MEDIUM, SMALL, XSMALL, XXSMALL, XXXSMALL }

class ResponsiveVariantProps {
  final TextStyle lg; // > 900
  final TextStyle md; // upto 900
  ResponsiveVariantProps({required this.lg, required this.md});
}

class Text extends HookWidget {
  final Variant variant;
  final String data;
  final TextAlign textAlign;
  final TextStyle style;
  const Text(this.data,
      {Key? key,
      this.variant = Variant.H2,
      this.textAlign = TextAlign.start,
      this.style = const TextStyle()})
      : super(key: key);

  ResponsiveVariantProps _getResponsiveVariantProps(
      Variant variant, TextTheme textTheme) {
    switch (variant) {
      case Variant.H1:
        TextStyle headline1Style = textTheme.headline1 != null
            ? textTheme.headline1!
            : TextStyle(fontWeight: FontWeight.normal);
        return ResponsiveVariantProps(
            lg: headline1Style.copyWith(fontSize: 112),
            md: headline1Style.copyWith(fontSize: 84));

      case Variant.H2:
        TextStyle headline2Style = textTheme.headline2 != null
            ? textTheme.headline2!
            : TextStyle(fontWeight: FontWeight.normal);
        return ResponsiveVariantProps(
            lg: headline2Style.copyWith(fontSize: 56),
            md: headline2Style.copyWith(fontSize: 42));

      case Variant.H3:
        TextStyle headline3Style = textTheme.headline3 != null
            ? textTheme.headline3!
            : TextStyle(fontWeight: FontWeight.normal);
        return ResponsiveVariantProps(
            lg: headline3Style.copyWith(fontSize: 45),
            md: headline3Style.copyWith(fontSize: 35));

      case Variant.H4:
        TextStyle headline4Style = textTheme.headline4 != null
            ? textTheme.headline4!
            : TextStyle(fontWeight: FontWeight.w600);
        return ResponsiveVariantProps(
            lg: headline4Style.copyWith(fontSize: 34),
            md: headline4Style.copyWith(fontSize: 25.5));

      case Variant.H5:
        TextStyle headline5Style = textTheme.headline5 != null
            ? textTheme.headline5!
            : TextStyle(fontWeight: FontWeight.w600);
        return ResponsiveVariantProps(
            lg: headline5Style.copyWith(fontSize: 24),
            md: headline5Style.copyWith(fontSize: 14));

      case Variant.H6:
        TextStyle headline6Style = textTheme.headline6 != null
            ? textTheme.headline6!
            : TextStyle(fontWeight: FontWeight.w600);
        return ResponsiveVariantProps(
            lg: headline6Style.copyWith(fontSize: 20),
            md: headline6Style.copyWith(fontSize: 16));
    }
  }

  TextStyle _getVariantProps(
      ResponsiveVariantProps responsiveVariantProps, Size size) {
    if (size.width > 900) return responsiveVariantProps.lg;
    return responsiveVariantProps.md;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final responsiveVariantProps =
        _getResponsiveVariantProps(variant, textTheme);
    final textStyle = _getVariantProps(responsiveVariantProps, size);
    return SelectableText(
      data,
      style: textStyle.merge(style),
      textAlign: textAlign,
    );
  }
}
