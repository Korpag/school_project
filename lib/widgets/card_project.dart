import 'package:flutter/material.dart';
import 'package:school_project/theme/app_image.dart';
import 'package:school_project/widgets/description.dart';
import 'package:school_project/widgets/label.dart';
import 'dart:math';

import 'package:school_project/widgets/time_counter.dart';

class ProjectCard extends StatelessWidget {
  /// Заголовок лейбла
  final String? titleLabel;

  /// цвет лейбла
  final Color? colorLabel;

  /// Строка для изображения
  final String? image;

  /// Описание
  final String? description;

  /// Дата
  final String? date;

  /// Функция на нажатие карточки
  final Function()? onTap;

  const ProjectCard(
      {Key? key,
      this.titleLabel,
      this.colorLabel,
      this.image,
      this.description,
      this.date,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _intValue = Random().nextInt(20) + 20;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Изображение
          SizedBox(
              height: _height * (_intValue / 100),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: image != null
                    ? FadeInImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: const AssetImage(CustomImage.placeholder),
                        image: NetworkImage(image!))
                    : null,
              )),

          /// Лейбл
          if (titleLabel != null)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 6),
              child: Label(
                title: titleLabel,
                color: colorLabel,
              ),
            ),

          /// Описание
          Description(
            description: description,
            maxLinesDescription: 3,
          ),

          /// Дата
          if (date != null) const SizedBox(height: 6),
          if (date != null) TimeCounter(date: date!)
        ],
      ),
    );
  }
}
