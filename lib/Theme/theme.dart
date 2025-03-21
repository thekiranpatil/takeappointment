import 'package:flutter/services.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class TypographyRegular {
  static TextTheme textThemeLight = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      overflow: TextOverflow.ellipsis,
      height: 64 / 57,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      overflow: TextOverflow.ellipsis,
      height: 52 / 45,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      overflow: TextOverflow.ellipsis,
      height: 44 / 36,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      overflow: TextOverflow.ellipsis,
      height: 40 / 32,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      overflow: TextOverflow.ellipsis,
      height: 36 / 28,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      overflow: TextOverflow.ellipsis,
      height: 32 / 24,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      overflow: TextOverflow.ellipsis,
      height: 28 / 22,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      letterSpacing: 0.15,
      overflow: TextOverflow.ellipsis,
      height: 24 / 16,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      letterSpacing: 0.1,
      overflow: TextOverflow.ellipsis,
      height: 20 / 14,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      letterSpacing: 0.1,
      overflow: TextOverflow.ellipsis,
      height: 20 / 14,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      letterSpacing: 0.5,
      overflow: TextOverflow.ellipsis,
      height: 16 / 12,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      letterSpacing: 0.5,
      overflow: TextOverflow.ellipsis,
      height: 16 / 11,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      letterSpacing: 0.5,
      overflow: TextOverflow.ellipsis,
      height: 24 / 16,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      letterSpacing: 0.25,
      overflow: TextOverflow.ellipsis,
      height: 20 / 14,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.gray700,
      letterSpacing: 0.4,
      overflow: TextOverflow.ellipsis,
      height: 16 / 12,
    ),
  );

  static TextTheme textThemeDark = textThemeLight.copyWith(
    displayLarge: TextStyle(
      color: AppColors.gray50,
    ),
    displayMedium: TextStyle(
      color: AppColors.gray50,
    ),
    displaySmall: TextStyle(
      color: AppColors.gray50,
    ),
    headlineLarge: TextStyle(
      color: AppColors.gray50,
    ),
    headlineMedium: TextStyle(
      color: AppColors.gray50,
    ),
    headlineSmall: TextStyle(
      color: AppColors.gray50,
    ),
    titleLarge: TextStyle(
      color: AppColors.gray50,
    ),
    titleMedium: TextStyle(
      color: AppColors.gray50,
    ),
    titleSmall: TextStyle(
      color: AppColors.gray50,
    ),
    labelLarge: TextStyle(
      color: AppColors.gray50,
    ),
    labelMedium: TextStyle(
      color: AppColors.gray50,
    ),
    labelSmall: TextStyle(
      color: AppColors.gray50,
    ),
    bodyLarge: TextStyle(
      color: AppColors.gray50,
    ),
    bodyMedium: TextStyle(
      color: AppColors.gray50,
    ),
    bodySmall: TextStyle(
      color: AppColors.gray50,
    ),
  );
}

class TypographyMedium {
  static TextTheme textThemeLight = TextTheme(
    displayLarge: TypographyRegular.textThemeLight.displayLarge!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    displayMedium: TypographyRegular.textThemeLight.displayMedium!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    displaySmall: TypographyRegular.textThemeLight.displaySmall!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: TypographyRegular.textThemeLight.headlineLarge!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TypographyRegular.textThemeLight.headlineMedium!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TypographyRegular.textThemeLight.headlineSmall!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TypographyRegular.textThemeLight.titleLarge!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TypographyRegular.textThemeLight.titleMedium!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TypographyRegular.textThemeLight.titleSmall!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TypographyRegular.textThemeLight.labelLarge!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TypographyRegular.textThemeLight.labelMedium!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TypographyRegular.textThemeLight.labelSmall!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TypographyRegular.textThemeLight.bodyLarge!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TypographyRegular.textThemeLight.bodyMedium!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TypographyRegular.textThemeLight.bodySmall!.copyWith(
      fontWeight: FontWeight.w500,
    ),
  );

  static TextTheme textThemeDark = textThemeLight.copyWith(
    displayLarge: TextStyle(
      color: AppColors.gray50,
    ),
    displayMedium: TextStyle(
      color: AppColors.gray50,
    ),
    displaySmall: TextStyle(
      color: AppColors.gray50,
    ),
    headlineLarge: TextStyle(
      color: AppColors.gray50,
    ),
    headlineMedium: TextStyle(
      color: AppColors.gray50,
    ),
    headlineSmall: TextStyle(
      color: AppColors.gray50,
    ),
    titleLarge: TextStyle(
      color: AppColors.gray50,
    ),
    titleMedium: TextStyle(
      color: AppColors.gray50,
    ),
    titleSmall: TextStyle(
      color: AppColors.gray50,
    ),
    labelLarge: TextStyle(
      color: AppColors.gray50,
    ),
    labelMedium: TextStyle(
      color: AppColors.gray50,
    ),
    labelSmall: TextStyle(
      color: AppColors.gray50,
    ),
    bodyLarge: TextStyle(
      color: AppColors.gray50,
    ),
    bodyMedium: TextStyle(
      color: AppColors.gray50,
    ),
    bodySmall: TextStyle(
      color: AppColors.gray50,
    ),
  );

}

class TypographySemibold {
  static TextTheme textThemeLight = TextTheme(
    displayLarge: TypographyRegular.textThemeLight.displayLarge!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    displayMedium: TypographyRegular.textThemeLight.displayMedium!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TypographyRegular.textThemeLight.displaySmall!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TypographyRegular.textThemeLight.headlineLarge!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TypographyRegular.textThemeLight.headlineMedium!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TypographyRegular.textThemeLight.headlineSmall!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TypographyRegular.textThemeLight.titleLarge!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TypographyRegular.textThemeLight.titleMedium!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TypographyRegular.textThemeLight.titleSmall!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TypographyRegular.textThemeLight.labelLarge!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TypographyRegular.textThemeLight.labelMedium!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TypographyRegular.textThemeLight.labelSmall!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TypographyRegular.textThemeLight.bodyLarge!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TypographyRegular.textThemeLight.bodyMedium!.copyWith(
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TypographyRegular.textThemeLight.bodySmall!.copyWith(
      fontWeight: FontWeight.w600,
    ),
  );

  static TextTheme textThemeDark = TextTheme(
    displayLarge: TypographyRegular.textThemeLight.displayLarge!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    displayMedium: TypographyRegular.textThemeLight.displayMedium!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    displaySmall: TypographyRegular.textThemeLight.displaySmall!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    headlineLarge: TypographyRegular.textThemeLight.headlineLarge!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    headlineMedium: TypographyRegular.textThemeLight.headlineMedium!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    headlineSmall: TypographyRegular.textThemeLight.headlineSmall!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    titleLarge: TypographyRegular.textThemeLight.titleLarge!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    titleMedium: TypographyRegular.textThemeLight.titleMedium!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    titleSmall: TypographyRegular.textThemeLight.titleSmall!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    labelLarge: TypographyRegular.textThemeLight.labelLarge!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    labelMedium: TypographyRegular.textThemeLight.labelMedium!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    labelSmall: TypographyRegular.textThemeLight.labelSmall!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    bodyLarge: TypographyRegular.textThemeLight.bodyLarge!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    bodyMedium: TypographyRegular.textThemeLight.bodyMedium!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
    bodySmall: TypographyRegular.textThemeLight.bodySmall!.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.gray50,
    ),
  );
  
}

class CustomTextStyles {
  static TextStyle inputLabel = TypographyMedium.textThemeLight.bodyMedium!;
}

/// AppAmounts is a class that contains the amounts for multiple usage.
class Amount {
  /// Screen Horizontal Edge Margin
  static const double screenMargin = 16;
}

/// AppBorderRadius is a class that contains the border radius for buttons. xxsm, xsm, sm, md, lg, xl, and xxl are the sizes of the circular corner radius
class AppBorderRadius {
  /// 0px All Corners
  static const BorderRadius k00 = BorderRadius.zero;

  /// 2px All Corners
  static const BorderRadius k02 = BorderRadius.all(Radius.circular(2));

  /// 4px All Corners
  static const BorderRadius k04 = BorderRadius.all(Radius.circular(4));

  /// 6 px All Corners
  static const BorderRadius k06 = BorderRadius.all(Radius.circular(8));

  /// 8px All Corners
  static const BorderRadius k08 = BorderRadius.all(Radius.circular(8));

  /// 10px All Corners
  static const BorderRadius k10 = BorderRadius.all(Radius.circular(10));

  /// 12px All Corners
  static const BorderRadius k12 = BorderRadius.all(Radius.circular(12));

  /// 16px All Corners
  static const BorderRadius k16 = BorderRadius.all(Radius.circular(16));

  /// 24px All Corners
  static const BorderRadius k24 = BorderRadius.all(Radius.circular(24));

  /// 32px All Corners
  static const BorderRadius k32 = BorderRadius.all(Radius.circular(32));
}

/// AppButtonStyles is a class that contains the button styles for the app. filledLarge, filledMedium, filledSmall, outlinedLarge, outlinedMedium, outlinedSmall, and text are the button styles.
class AppButtonStyle {
  /// ButtonStyle for a filled button with large text
  static ButtonStyle filledLarge = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(AppColors.primarySwatch.shade500),
    foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    iconSize: WidgetStateProperty.all<double>(24),
    iconColor: WidgetStateProperty.all<Color>(AppColors.white),
    elevation: WidgetStateProperty.all<double>(0),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TypographySemibold.textThemeLight.titleMedium!.copyWith(color: AppColors.white),
    ),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
    ),
  );

  /// ButtonStyle for filled medium buttons
  static ButtonStyle filledMedium = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(AppColors.primarySwatch.shade500),
    foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    iconSize: WidgetStateProperty.all<double>(24),
    iconColor: WidgetStateProperty.all<Color>(AppColors.white),
    elevation: WidgetStateProperty.all<double>(0),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TypographySemibold.textThemeLight.bodyMedium!.copyWith(color: AppColors.white),
    ),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ),
    ),
  );

  /// ButtonStyle for filled small buttons
  static ButtonStyle filledSmall = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(AppColors.primarySwatch.shade500),
    foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    iconSize: WidgetStateProperty.all<double>(18),
    iconColor: WidgetStateProperty.all<Color>(AppColors.white),
    elevation: WidgetStateProperty.all<double>(0),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TypographySemibold.textThemeLight.bodySmall!.copyWith(color: AppColors.white),
    ),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ),
    ),
  );

  /// ButtonStyle for outlined large buttons
  static ButtonStyle outlinedLarge = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(AppColors.transparent),
    foregroundColor: WidgetStateProperty.all<Color>(AppColors.primarySwatch.shade500),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.k08,
        side: BorderSide(color: AppColors.stroke),
      ),
    ),
    elevation: WidgetStateProperty.all<double>(0),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TypographyRegular.textThemeLight.titleMedium!.copyWith(color: AppColors.primarySwatch.shade500),
    ),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
    ),
  );

  /// ButtonStyle for outlined medium buttons
  static ButtonStyle outlinedMedium = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(AppColors.transparent),
    foregroundColor: WidgetStateProperty.all<Color>(AppColors.primarySwatch.shade500),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.k08,
        side: BorderSide(color: AppColors.stroke),
      ),
    ),
    elevation: WidgetStateProperty.all<double>(0),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TypographyRegular.textThemeLight.bodyMedium!.copyWith(color: AppColors.primarySwatch.shade500),
    ),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ),
    ),
  );

  // ButtonStyle for outlined small buttons
  static ButtonStyle outlinedSmall = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(AppColors.transparent),
    foregroundColor: WidgetStateProperty.all<Color>(AppColors.primarySwatch.shade500),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.k08,
        side: BorderSide(color: AppColors.stroke),
      ),
    ),
    elevation: WidgetStateProperty.all<double>(0),
    textStyle: WidgetStateProperty.all<TextStyle>(
      TypographyRegular.textThemeLight.bodySmall!.copyWith(color: AppColors.primarySwatch.shade500),
    ),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ),
    ),
  );

  // ButtonStyle for text buttons
  static ButtonStyle textSmall = TextButton.styleFrom(
    foregroundColor: AppColors.primarySwatch.shade500,
    textStyle: TypographyRegular.textThemeLight.bodySmall!.copyWith(
      color: AppColors.primarySwatch.shade500,
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 8,
    ),
  );

  static ButtonStyle textLarge = TextButton.styleFrom(
    foregroundColor: AppColors.primarySwatch.shade500,
    textStyle: TypographyRegular.textThemeLight.bodyLarge!.copyWith(
      color: AppColors.primarySwatch.shade500,
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 8,
    ),
  );
}

class AppInputDecoration {
  InputDecoration searchField = const InputDecoration();
}

class DrawerListTileThemeData {
  static ListTileThemeData inactive = ListTileThemeData(
    tileColor: AppColors.transparent,
    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    // visualDensity: VisualDensity.compact,
    shape: const RoundedRectangleBorder(
      borderRadius: AppBorderRadius.k04,
    ),
    titleTextStyle: TypographyRegular.textThemeLight.titleMedium!.copyWith(
      color: AppColors.gray50,
    ),
    leadingAndTrailingTextStyle: TypographyRegular.textThemeLight.titleMedium!.copyWith(
      color: AppColors.gray50,
    ),
    iconColor: AppColors.icon,
  );

  static ListTileThemeData active = ListTileThemeData(
    tileColor: AppColors.primarySwatch.shade500,
    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    shape: const RoundedRectangleBorder(
      borderRadius: AppBorderRadius.k04,
    ),
    titleTextStyle: TypographyRegular.textThemeLight.titleMedium!.copyWith(
      color: AppColors.primarySwatch.shade500,
    ),
    leadingAndTrailingTextStyle: TypographyRegular.textThemeLight.titleMedium!.copyWith(
      color: AppColors.primarySwatch.shade500,
    ),
    iconColor: AppColors.primarySwatch.shade500,
  );
}

/// CustomTheme is a class that contains the theme for the app
class CustomTheme {
  /// Light Theme for the app
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: GoogleFonts.inter().fontFamily,
    fontFamilyFallback: const <String>['Inter', 'Roboto'],
    primaryColor: AppColors.primarySwatch.shade500,
    primarySwatch: AppColors.primarySwatch,
    colorScheme: ColorScheme.light(
      primary: AppColors.white,
      secondary: AppColors.secondary,
      error: AppColors.danger500,
        surface: AppColors.background,
    ),
    drawerTheme: const DrawerThemeData(
      elevation: 0,
      backgroundColor: AppColors.white,
    ),
      textTheme: TypographyRegular.textThemeLight,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppButtonStyle.filledLarge,
    ),
    textButtonTheme: TextButtonThemeData(
      style: AppButtonStyle.textSmall,
    ),
    switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all<Color>(AppColors.white),
        trackColor: WidgetStateProperty.all<Color>(AppColors.primarySwatch.shade500),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TypographyRegular.textThemeLight.bodyMedium!,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.neutral700, width: 1), borderRadius: AppBorderRadius.k10),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.neutral700, width: 1), borderRadius: AppBorderRadius.k10),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primarySwatch.shade500, width: 2),
        borderRadius: AppBorderRadius.k10,
      ),
      errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.danger500, width: 1), borderRadius: AppBorderRadius.k10),
      focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.danger500, width: 2), borderRadius: AppBorderRadius.k10),
        labelStyle: TypographyRegular.textThemeLight.bodyLarge!.copyWith(color: AppColors.gray50),
      floatingLabelBehavior: FloatingLabelBehavior.never,
        floatingLabelStyle:
            TypographyRegular.textThemeLight.bodyMedium!.copyWith(color: AppColors.primarySwatch.shade500),
        hintStyle: TypographyRegular.textThemeLight.bodySmall!.copyWith(color: AppColors.gray50),
        errorStyle: TypographyRegular.textThemeLight.bodySmall!.copyWith(color: AppColors.danger500),
        helperStyle: TypographyRegular.textThemeLight.bodySmall!.copyWith(color: AppColors.gray50),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      errorMaxLines: 1.toInt(),
      iconColor: AppColors.primarySwatch.shade500,
      prefixIconColor: AppColors.icon,
      suffixIconColor: AppColors.icon,
    ),
    radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all<Color>(AppColors.primarySwatch.shade500),
    ),
    tabBarTheme: TabBarTheme(
      dividerColor: AppColors.transparent,
      labelColor: AppColors.white,
      unselectedLabelColor: AppColors.gray50,
        labelStyle: TypographyRegular.textThemeLight.labelLarge,
        unselectedLabelStyle: TypographyRegular.textThemeLight.labelLarge!.copyWith(color: AppColors.gray50),
      indicator: BoxDecoration(
        borderRadius: AppBorderRadius.k10,
        color: AppColors.primarySwatch.shade500,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      splashFactory: NoSplash.splashFactory,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primarySwatch.shade500,
      foregroundColor: AppColors.white,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: AppColors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      // visualDensity: VisualDensity.compact,
        titleTextStyle: TypographyRegular.textThemeLight.titleMedium!,
        subtitleTextStyle: TypographyRegular.textThemeLight.bodyMedium!.copyWith(
        color: AppColors.gray50,
      ),
      iconColor: AppColors.icon,
        leadingAndTrailingTextStyle: TypographyRegular.textThemeLight.labelMedium!.copyWith(
        color: AppColors.gray50,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.neutral700,
      thickness: 1,
      indent: Amount.screenMargin,
      endIndent: Amount.screenMargin,
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.k04),
        checkColor: WidgetStateProperty.all(AppColors.white),
        fillColor: WidgetStateProperty.all(AppColors.primarySwatch.shade500),
    ),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark, // For Android
          statusBarBrightness: Brightness.dark, // For iOS
        ),
      color: AppColors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: AppColors.icon,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(color: AppColors.icon),
        titleTextStyle: TypographySemibold.textThemeLight.titleMedium!.copyWith(
        color: AppColors.gray700,
      ),
    ),
      scaffoldBackgroundColor: AppColors.white,
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.k16),
      actionsPadding: EdgeInsets.symmetric(horizontal: 50),
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.white
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.white,
    ),
    textSelectionTheme:TextSelectionThemeData(
      selectionColor: AppColors.primarySwatch,
      selectionHandleColor: AppColors.primarySwatch,
      cursorColor: AppColors.primarySwatch,
    )
  );
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: false,
      fontFamily: GoogleFonts.inter().fontFamily,
      fontFamilyFallback: const <String>['Inter', 'Roboto'],
      primaryColor: AppColors.primarySwatch.shade500,
      primarySwatch: AppColors.primarySwatch,
      colorScheme: ColorScheme.dark(
        primary: AppColors.black,
        secondary: AppColors.secondary,
        error: AppColors.danger500,
        surface: AppColors.backgroundDark,
      ),
      drawerTheme: const DrawerThemeData(
        elevation: 0,
        backgroundColor: AppColors.backgroundDark,
      ),
      textTheme: TypographyRegular.textThemeDark,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppButtonStyle.filledLarge,
      ),
      textButtonTheme: TextButtonThemeData(
        style: AppButtonStyle.textSmall,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all<Color>(AppColors.white),
        trackColor: WidgetStateProperty.all<Color>(AppColors.primarySwatch.shade500),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: TypographyRegular.textThemeDark.bodyMedium!.copyWith(
            color: AppColors.gray50,
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TypographyRegular.textThemeDark.bodyLarge!.copyWith(color: AppColors.gray50),
          )
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray50, width: 1), borderRadius: AppBorderRadius.k10),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray50, width: 1), borderRadius: AppBorderRadius.k10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primarySwatch.shade500, width: 2),
          borderRadius: AppBorderRadius.k10,
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.danger500, width: 1), borderRadius: AppBorderRadius.k10),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.danger500, width: 2), borderRadius: AppBorderRadius.k10),
        labelStyle: TypographyRegular.textThemeDark.bodyLarge!.copyWith(color: AppColors.gray50),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        floatingLabelStyle:
            TypographyRegular.textThemeDark.bodyMedium!.copyWith(color: AppColors.primarySwatch.shade500),
        hintStyle: TypographyRegular.textThemeDark.bodySmall!.copyWith(color: AppColors.gray50),
        errorStyle: TypographyRegular.textThemeDark.bodySmall!.copyWith(color: AppColors.danger500),
        helperStyle: TypographyRegular.textThemeDark.bodySmall!.copyWith(color: AppColors.gray50),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        errorMaxLines: 1.toInt(),
        iconColor: AppColors.primarySwatch.shade500,
        prefixIconColor: AppColors.icon,
        suffixIconColor: AppColors.icon,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all<Color>(AppColors.primarySwatch.shade500),
      ),
      tabBarTheme: TabBarTheme(
        dividerColor: AppColors.transparent,
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.gray50,
        labelStyle: TypographyRegular.textThemeDark.labelLarge,
        unselectedLabelStyle: TypographyRegular.textThemeDark.labelLarge!.copyWith(color: AppColors.gray50),
        indicator: BoxDecoration(
          borderRadius: AppBorderRadius.k10,
          color: AppColors.primarySwatch.shade500,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        splashFactory: NoSplash.splashFactory,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primarySwatch.shade500,
        foregroundColor: AppColors.white,
      ),
      listTileTheme: ListTileThemeData(
        tileColor: AppColors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        // visualDensity: VisualDensity.compact,
        titleTextStyle: TypographyRegular.textThemeDark.titleMedium!,
        subtitleTextStyle: TypographyRegular.textThemeDark.bodyMedium!.copyWith(
          color: AppColors.gray50,
        ),
        iconColor: AppColors.icon,
        leadingAndTrailingTextStyle: TypographyRegular.textThemeDark.labelMedium!.copyWith(
          color: AppColors.gray50,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.gray50,
        thickness: 1,
        indent: Amount.screenMargin,
        endIndent: Amount.screenMargin,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.k04),
        checkColor: WidgetStateProperty.all(AppColors.white),
        fillColor: WidgetStateProperty.all(AppColors.primarySwatch.shade500),
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColors.backgroundDark,
          statusBarIconBrightness: Brightness.light, // For Android
          statusBarBrightness: Brightness.light, // For iOS
        ),
        // color: AppColors.backgroundDark,
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.icon,
          size: 24,
        ),
        actionsIconTheme: const IconThemeData(color: AppColors.icon),
        titleTextStyle: TypographySemibold.textThemeLight.titleMedium!.copyWith(
          color: AppColors.gray50,
        ),
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      dialogTheme: const DialogTheme(
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.k16),
        actionsPadding: EdgeInsets.symmetric(horizontal: 50),
        backgroundColor: AppColors.backgroundDark,
        surfaceTintColor: AppColors.backgroundDark,
        shadowColor: AppColors.black,
        titleTextStyle: TextStyle(color: AppColors.gray50, fontSize: 24),
        contentTextStyle: TextStyle(color: AppColors.gray50),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.backgroundDark,
        shadowColor: AppColors.backgroundDark,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.primarySwatch,
        selectionHandleColor: AppColors.primarySwatch,
        cursorColor: AppColors.primarySwatch,
      ));


}
