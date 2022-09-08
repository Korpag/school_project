import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/theme/app_icons.dart';

class Button extends StatefulWidget {
  /// Функция нажтия на кнопку.
  final Function? onTap;

  /// Высота кнопки
  final double? height;

  /// Значение закругление углов кнопки
  final double borderRadius;

  /// Цвет кнопки
  final Color color;

  /// Нужна ли заливка
  final bool fillColor;

  /// Отступ горизонтальный для содержимого
  final double horizontalPadding;

  /// Текст кнопки / Если поле пустое, будет показываться иконка
  final String? text;

  /// Цвет текста
  final Color colorText;

  /// Толщина текста
  final FontWeight fontWeight;

  /// Размер текста
  final double fontSize;

  /// Нужно ли подчеркивание текста
  final bool textDirection;

  /// Иконка
  final IconData? icon;

  /// Цвет иконки
  final Color? iconColor;

  /// Доступность кнопки
  final bool? permission;

  /// Ассинхронный запрос
  final Future<dynamic>? Function()? onReady;

  /// Виджет вместо иконки, если нужен
  final Widget? widgetIcon;

  const Button(
      {Key? key,
      this.height,
      this.borderRadius = 10,
      this.color = AppColor.button,
      this.horizontalPadding = 22,
      this.colorText = AppColor.white,
      this.fontWeight = FontWeight.w500,
      this.fontSize = 16,
      this.onTap,
      this.fillColor = true,
      this.text,
      this.icon,
      this.permission,
      this.textDirection = false,
      this.onReady,
      this.iconColor,
      this.widgetIcon})
      : super(key: key);

  /// Стандартная маленькая кнопка
  static mini(
      {bool fillColor = true,
      Color colorText = AppColor.white,
      double horizontalPadding = 22,
      String? text,
      Color color = AppColor.button,
      double borderRadius = 10,
      IconData? icon,
      FontWeight fontWeight = FontWeight.w400,
      Function()? onTap}) {
    return Button(
      text: text,
      fontSize: 14,
      color: color,
      borderRadius: borderRadius,
      fillColor: fillColor,
      colorText: colorText,
      height: 30,
      icon: icon,
      horizontalPadding: horizontalPadding,
      fontWeight: fontWeight,
      onTap: onTap,
    );
  }

  /// Стандартная большая кнопка
  static large(
      {bool fillColor = true,
      Color colorText = AppColor.white,
      Color color = AppColor.button,
      double horizontalPadding = 22,
      String? text,
      IconData? icon,
      double borderRadius = 10,
      FontWeight fontWeight = FontWeight.w500,
      Function()? onTap}) {
    return Button(
      text: text,
      height: 50,
      color: color,
      borderRadius: borderRadius,
      fillColor: fillColor,
      colorText: colorText,
      icon: icon,
      horizontalPadding: horizontalPadding,
      fontWeight: fontWeight,
      onTap: onTap,
    );
  }

  /// Кнопка с обратной связью
  static feedback(
      {bool? permission,
      String? text,
      Color colorText = AppColor.button,
      FontWeight fontWeight = FontWeight.w400,
      bool textDirection = true,
      Function()? onTap,
      Future<dynamic>? Function()? onReady,
      double fontSize = 12}) {
    return Button(
      fillColor: false,
      permission: permission,
      height: null,
      text: text,
      horizontalPadding: 0,
      textDirection: textDirection,
      fontSize: fontSize,
      onReady: onReady,
      onTap: onTap,
      fontWeight: fontWeight,
      colorText: colorText,
    );
  }

  /// Простая кнопка назад
  static back(
      {Function()? onTap, double size = 24, Color color = AppColor.white}) {
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: CustomIcons.backButton(color: color),
        ));
  }

  /// Плавующая кнопка
  static floating({Function()? onTap, Widget? widgetIcon}) {
    return Button(
      widgetIcon: widgetIcon,
      height: 50,
      onTap: onTap,
    );
  }

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool? _loader;

  /// Прогресс Индикатор, если такой необходим
  Row _indicator() {
    return Row(
      children: [
        SizedBox(
          width: widget.fontSize,
          height: widget.fontSize,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: AppColor.disabledText,
            color: AppColor.circularIndicatorColor,
          ),
        ),
        const SizedBox(width: 5)
      ],
    );
  }

  /// Функция нажатия на кнопку
  void _onTap() async {
    if (widget.onTap != null) {
      widget.onTap!();
    }
    if (widget.onReady != null) {
      _loader = true;
      setState(() {});
      await widget.onReady!()?.then((value) {
        _loader = false;
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return GestureDetector(
        onTap: _onTap,
        child: widget.text != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Ассинхронный индикатор
                  if (_loader == true && widget.onReady != null) _indicator(),

                  /// Кнопка с текстом
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.horizontalPadding),
                      height: widget.height,
                      decoration: BoxDecoration(
                          color: widget.fillColor ? widget.color : null,
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.text ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: _theme.textTheme.button!.copyWith(
                                  color: widget.permission == false
                                      ? AppColor.disabledText
                                      : widget.colorText,
                                  fontWeight: widget.fontWeight,
                                  decoration: widget.textDirection
                                      ? TextDecoration.underline
                                      : null,
                                  fontSize: widget.fontSize)),
                        ],
                      ),
                    ),
                  ),
                ],
              )

            /// Кнопка с иконкой
            : SizedBox(
                height: widget.height,
                width: widget.height,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: widget.color),
                    child: widget.widgetIcon ??
                        Icon(widget.icon ?? Icons.arrow_forward_ios_rounded,
                            color: widget.iconColor ?? AppColor.white,
                            size: (widget.height ?? 0) * 0.65))));
  }
}
