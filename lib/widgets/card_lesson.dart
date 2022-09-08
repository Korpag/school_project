import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_project/theme/app_color.dart';

class LessonCard extends StatelessWidget {
  /// Что произойдет если нажать на карточку
  final Function()? onTap;

  /// Строка для изображения
  final String? image;

  /// Цвет карточки
  final Color colorCard;

  /// Title урока
  final String? title;

  /// Дата урока
  final String? date;

  const LessonCard(
      {Key? key,
      this.onTap,
      this.image,
      this.colorCard = AppColor.button,
      this.title,
      this.date})
      : super(key: key);

  Container _text(
      {String? text,
      double fontSize = 14,
      required ThemeData theme,
      required BuildContext context}) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 3),
      child: text != null
          ? Text(text,
              style: theme.textTheme.caption!.copyWith(fontSize: fontSize))
          : const SizedBox(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              image: image != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.centerRight,
                      image: NetworkImage(image!))
                  : null,
              borderRadius: BorderRadius.circular(20),
              color: colorCard.withOpacity(0.1)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 31, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: const Alignment(-0.15, 0),
                    end: const Alignment(0.35, 0),
                    colors: [colorCard, Colors.white.withOpacity(0.01)])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _text(theme: _theme, text: title, context: context),
                if (date != null)
                  _text(
                      theme: _theme,
                      text: DateFormat('d MMMM', 'Ru_ru')
                          .format(DateTime.parse(date!)),
                      fontSize: 20,
                      context: context),
              ],
            ),
          ),
        ));
  }
}
