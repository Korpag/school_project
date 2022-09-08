import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';

class Label extends StatelessWidget {
  /// Горизонтальный паддинг для внутреннего наполнения
  final double horizontalPadding;

  /// Высота лейбла
  final double height;

  /// Тайтл лейбла
  final String? title;

  /// Цвет лейбла
  final Color? color;

  /// Цвет текста // В дальнейшем сделать зависимость от цвета лейбла, если будет такая необходимость
  final Color colorText;

  /// Толщина текста
  final FontWeight fontWeight;

  const Label(
      {Key? key,
      this.horizontalPadding = 11,
      this.height = 20,
      this.title,
      this.color,
      this.fontWeight = FontWeight.w400,
      this.colorText = AppColor.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return title != '' && title != null
        ? SizedBox(
            height: height,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color ?? AppColor.button),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title?.toUpperCase() ?? '',
                        style: _theme.textTheme.caption!.copyWith(
                            fontWeight: fontWeight,
                            letterSpacing: 0.92,
                            color: colorText,
                            fontSize: height * 0.55))
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
