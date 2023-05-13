import 'package:emplolance/utils/theme/widgets_themes/elevated_button_theme.dart';
import 'package:emplolance/utils/theme/widgets_themes/outlined_button_theme.dart';
import 'package:emplolance/utils/theme/widgets_themes/text_field_theme.dart';
import 'package:emplolance/utils/theme/widgets_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Mulish',
    scaffoldBackgroundColor: const Color(0xFF17181C),
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkElevatedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
