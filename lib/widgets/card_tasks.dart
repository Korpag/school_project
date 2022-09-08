import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/coin.dart';
import 'package:school_project/widgets/label.dart';
import 'package:school_project/widgets/time_counter.dart';

import 'description.dart';

class TasksCard extends StatelessWidget {
  /// Что произойдет если нажать на карточку
  final Function()? onTap;

  /// Цвет контейнера под иконку
  final Color color;

  /// Иконка
  final IconData icon;

  /// Текст лейбла
  final String? titleLabel;

  /// Цвет контейнера лейбла
  final Color? colorLabel;

  /// Дата
  final String? date;

  /// Стоимость задания
  final String? count;

  /// Краткое описание
  final String? description;

  const TasksCard(
      {Key? key,
      this.color = AppColor.button,
      this.icon = Icons.album_sharp,
      this.titleLabel,
      this.colorLabel,
      this.date,
      this.count,
      this.description,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _smallWidth = MediaQuery.of(context).size.width < 340 ? true : false;
    const double _height = 91;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _height,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            /// Контейнер с иконкой
            Container(
              height: _height - 1,
              width: _height - 1,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, size: _height * 0.8, color: AppColor.white),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Лейбл
                  if (titleLabel != null)
                    Label(title: titleLabel, color: colorLabel),

                  /// Краткое описание
                  if (description != null)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (titleLabel != null) const SizedBox(height: 2),
                          Description(
                              description: description, maxLinesDescription: 2),
                        ],
                      ),
                    ),

                  /// Время и стоимость задания
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      date != null
                          ? Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width / 2.35,
                              ),
                              child: TimeCounter(date: date!),
                            )
                          : const SizedBox(),
                      if (count != null)
                        Coin(
                            plus: false,
                            color: AppColor.coinBlack,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            offset: 3,
                            fontSize: _smallWidth ? 13 : 18,
                            iconSize: _smallWidth ? 18 : 35,
                            count: count)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
