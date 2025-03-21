import 'package:flutter/material.dart';

class AppColors {
  static const Color secondary = Color(0xFF000000);
  static const Color success = Color(0xFF00510D);
  static const Color icon = Color(0xFF536471);
  static const Color accent = Color(0xFF000000);
  static const Color background = Color(0xFFEDF0FF);
  static const Color backgroundDark = Color(0xFF171819);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color stroke = Color(0xFFD9D9D9);
  static const Color surface = Color(0xFF000000); // Background color for cards, dialogs, and sheets
  static const Color transparent = Color(0x00000000);
  static const Color complete = Color(0xFF389E0D);
  static const Color cancel = Color(0xFFCF1322);
  static const Color current = Color(0xFFE6F4FF);
  static const Color warningHigh = Color(0xFFAA2B2B);
  static const Color warningMedium = Color(0xFFFFAE43);

  /// Material Color Primary Swatch generated from [http://mcg.mbitson.com/]
  static const MaterialColor primarySwatch = const MaterialColor(
    0xFFE06287,
    <int, Color>{
      50: Color(0xFFFCEFF3),
      100: Color(0xFFF5CEDA),
      200: Color(0xFFF1B7C8),
      300: Color(0xFFEA96AF),
      400: Color(0xFFE6819F),
      500: Color(0xFFE06287),
      600: Color(0xFFCC597B),
      700: Color(0xFF9F4660),
      800: Color(0xFF7B364A),
      900: Color(0xFF5E2939),
    },
  );

  /// Neutral Neutral Swatches
  static const Color neutral25 = Color(0xFFFCFCFD);
  static const Color neutral50 = Color(0xFFFAFBFC);
  static const Color neutral100 = Color(0xFFF8F9FB);
  static const Color neutral200 = Color(0xFFF9F9F9);
  static const Color neutral300 = Color(0xFFF7F7F8);
  static const Color neutral400 = Color(0xFFFAFBFC);
  static const Color neutral500 = Color(0xFFEFEFF1);
  static const Color neutral600 = Color(0xFFEAEBF0);
  static const Color neutral700 = Color(0xFFDAE0E6);
  static const Color neutral800 = Color(0xFFA5ACBA);
  static const Color neutral900 = Color(0xFF7C8B9D);
  static const Color neutral950 = Color(0xFF6B7B8F);

  /// Gray Neutral Swatches
  static const Color gray25 = Color(0xff919BA7);
  static const Color gray50 = Color(0xff5F6D7E);
  static const Color gray100 = Color(0xff49556D);
  static const Color gray200 = Color(0xff384255);
  static const Color gray300 = Color(0xff2E3545);
  static const Color gray400 = Color(0xff333B48);
  static const Color gray500 = Color(0xff2E3646);
  static const Color gray600 = Color(0xff2C3444);
  static const Color gray700 = Color(0xff272D37);
  static const Color gray800 = Color(0xff252D3C);
  static const Color gray900 = Color(0xff1C2534);
  static const Color gray950 = Color(0xff151B28);

  /// Semantic Colors
  static const Color information25 = Color(0xffF5FAFF);
  static const Color information50 = Color(0xffF5F8FE);
  static const Color information100 = Color(0xffE8EFFD);
  static const Color information200 = Color(0xffB1CCFB);
  static const Color information300 = Color(0xffAEC9FE);
  static const Color information400 = Color(0xff648EF7);
  static const Color information500 = Color(0xff5390F8);
  static const Color information600 = Color(0xff437EF7);
  static const Color information700 = Color(0xff3971E7);
  static const Color information800 = Color(0xff3E67E3);
  static const Color information900 = Color(0xff2B63D9);
  static const Color information950 = Color(0xff1B4397);

  static const Color danger25 = Color(0xFFFDFCFC);
  static const Color danger50 = Color(0xFFFEF6F6);
  static const Color danger100 = Color(0xFFFFF2F0);
  static const Color danger200 = Color(0xFFFFDBD7);
  static const Color danger300 = Color(0xFFFEB8AE);
  static const Color danger400 = Color(0xFFFD5E49);
  static const Color danger500 = Color(0xFFF15146);
  static const Color danger600 = Color(0xFFF04438);
  static const Color danger700 = Color(0xFFE2341D);
  static const Color danger800 = Color(0xFFB02817);
  static const Color danger900 = Color(0xFF661929);
  static const Color danger950 = Color(0xFF3E2026);

  static const Color warning25 = Color(0xffFBFAF8);
  static const Color warning50 = Color(0xffFFF8EB);
  static const Color warning100 = Color(0xffFFE4C0);
  static const Color warning200 = Color(0xffFFDDA1);
  static const Color warning300 = Color(0xffFFD08A);
  static const Color warning400 = Color(0xffFFC772);
  static const Color warning500 = Color(0xffFFAE43);
  static const Color warning600 = Color(0xffEEA23E);
  static const Color warning700 = Color(0xffD78100);
  static const Color warning800 = Color(0xffA15C00);
  static const Color warning900 = Color(0xff6B3D00);
  static const Color warning950 = Color(0xff4D2C00);

  static const Color success25 = Color(0xffF0FAF0);
  static const Color success50 = Color(0xffF8FBF8);
  static const Color success100 = Color(0xffC9EBCB);
  static const Color success200 = Color(0xffA6E1A8);
  static const Color success300 = Color(0xff93D698);
  static const Color success400 = Color(0xff7FD184);
  static const Color success500 = Color(0xff5DC264);
  static const Color success600 = Color(0xff41AE49);
  static const Color success700 = Color(0xff2D8A39);
  static const Color success800 = Color(0xff27682C);
  static const Color success900 = Color(0xff1A451D);
  static const Color success950 = Color(0xff0D3510);

  static const Color purple25 = Color(0xffF9F8FB);
  static const Color purple50 = Color(0xffECEBFF);
  static const Color purple100 = Color(0xffC7C4FD);
  static const Color purple200 = Color(0xffABA7FD);
  static const Color purple300 = Color(0xff8F89FC);
  static const Color purple400 = Color(0xff736CFB);
  static const Color purple500 = Color(0xff5D55F6);
  static const Color purple600 = Color(0xff574EFA);
  static const Color purple700 = Color(0xff463EE3);
  static const Color purple800 = Color(0xff352DC8);
  static const Color purple900 = Color(0xff33059F);
  static const Color purple950 = Color(0xff1B0354);
}
