import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';

class Description extends StatelessWidget {
  /// Расстояние между заголовком и описанием
  final double distanceBetweenItems;

  /// Строка для заголовка
  final String? title;

  /// Размер текста заголовка
  final double fontSizeTitle;

  /// Цвет заголовка
  final Color colorTitle;

  /// Толщина заголовка
  final FontWeight fontWeightTitle;

  /// Максимальное кол-во строк для заголовка
  final int maxLinesTitle;

  /// Строка для описания
  final String? description;

  /// Размер текста описания
  final double fontSizeDescription;

  /// Толщина Описания
  final FontWeight fontWeightDescription;

  /// Цвет описания
  final Color colorDescription;

  /// Максимальное кол-во строк для описания
  final int? maxLinesDescription;

  /// Отцентровать текст
  final bool textAlignCenter;

  const Description(
      {Key? key,
      this.distanceBetweenItems = 10,
      this.title,
      this.description,
      this.colorDescription = AppColor.text,
      this.fontSizeDescription = 14,
      this.fontSizeTitle = 14,
      this.colorTitle = AppColor.textTitle,
      this.maxLinesTitle = 2,
      this.fontWeightTitle = FontWeight.w700,
      this.fontWeightDescription = FontWeight.w400,
      this.maxLinesDescription, this.textAlignCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Column(
      crossAxisAlignment: textAlignCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        /// Заголовок
        if (title != null)
          Text(title!,
              maxLines: maxLinesTitle,
              textAlign: textAlignCenter ? TextAlign.center : null,
              overflow: TextOverflow.ellipsis,
              style: _theme.textTheme.overline!.copyWith(
                  color: colorTitle,
                  fontSize: fontSizeTitle,
                  fontWeight: fontWeightTitle)),

        /// Отступ между тайтлом и описанием
        if (title != null && description != null)
          SizedBox(height: distanceBetweenItems),

        /// Описание
        if (description != null)
          Text(
            description!,
            textAlign: textAlignCenter ? TextAlign.center : null,
            overflow:
                maxLinesDescription != null ? TextOverflow.ellipsis : null,
            maxLines: maxLinesDescription,
            style: _theme.textTheme.caption!.copyWith(
                color: colorDescription,
                fontWeight: fontWeightDescription,
                fontSize: fontSizeDescription),
          )
      ],
    );
  }
}
