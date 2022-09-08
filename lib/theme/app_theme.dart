import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';

final ThemeData appThemeData = ThemeData(
  /// Цвет фона
  scaffoldBackgroundColor: AppColor.white,

  /// Шрифты
  textTheme: const TextTheme(
      button: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          color: AppColor.white,
          letterSpacing: 0,
          fontWeight: FontWeight.w500),
      caption: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: AppColor.white,
          letterSpacing: 0,
          fontWeight: FontWeight.w400),
      overline: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: AppColor.white,
          letterSpacing: 0,
          fontWeight: FontWeight.w700),
      headline1: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: AppColor.text,
          letterSpacing: 0,
          fontWeight: FontWeight.w300)),

  /// Инпут
  inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      focusedErrorBorder: _border(color: AppColor.error),
      errorBorder: _border(color: AppColor.error),
      focusedBorder: _border(color: AppColor.button),
      enabledBorder: _border(color: AppColor.button.withOpacity(0.1))),

  /// Чекбокс
  checkboxTheme: CheckboxThemeData(
    splashRadius: _borderRadius,
    side: MaterialStateBorderSide.resolveWith((states) => BorderSide.none),
  ),
);

/// Залить фон по умолчанию в пустом значении нельзя, поэтому мы обернули чек-бокс в контейнер с фоном, но ему требуется аналогичное закругление, что и в теме чек бокса
/// Нам нужно достучаться до значения в BorderRadius.circular, но напрямую обратится нельзя
/// А к сплеш радиусу, можно. Поэтому мы делаем общую переменую.
const double _borderRadius = 2;

/// Цвета бордерсайда в зависимости от стейта чекбокса
Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.selected,
  };
  if (states.any(interactiveStates.contains)) {
    return AppColor.textTitle;
  }
  return AppColor.black;
}

/// Универсальный бордер для инпута
UnderlineInputBorder _border({required Color color}) {
  return UnderlineInputBorder(borderSide: BorderSide(color: color, width: 2));
}
