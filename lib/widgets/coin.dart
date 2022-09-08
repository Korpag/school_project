import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/theme/app_icons.dart';

class Coin extends StatelessWidget {
  /// Тип иконки
  final Image? icon;

  /// Размеры иконки
  final double iconSize;

  /// Реверс содержимого
  final bool reversed;

  /// Кол-во монет
  final String? count;

  /// Описание
  final String? description;

  ///Размеры текста
  final double? fontSize;

  /// Цвет текста
  final Color? color;

  /// Нужен ли плюс
  final bool plus;

  /// Нужно ли расстояние между count и icon
  final double? offset;

  /// Равнение элементов
  final CrossAxisAlignment crossAxisAlignment;

  const Coin(
      {Key? key,
      this.icon,
      this.reversed = false,
      this.count,
      this.description,
      this.iconSize = 40,
      this.fontSize,
      this.color,
      this.plus = true,
      this.offset,
      this.crossAxisAlignment = CrossAxisAlignment.center})
      : super(key: key);

  Column _coin(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '${reversed ? '' : plus ? '+' : ''}${count ?? '0'}'
                .replaceAllMapped(RegExp(r"(\d)(?=(\d{3})+(?!\d))"),
                    (match) => "${match.group(0)} "),
            style: theme.textTheme.overline!.copyWith(
                fontSize: reversed ? (fontSize ?? 35) : (fontSize ?? 20),
                color: reversed
                    ? (color ?? AppColor.white)
                    : (color ?? AppColor.coinBlack))),
        if (description != null && reversed == true)
          Text(
            description ?? '',
            style: theme.textTheme.caption!
                .copyWith(fontSize: 12, color: AppColor.coinDescription),
          )
      ],
    );
  }

  SizedBox _icon() {
    return SizedBox(
      height: iconSize,
      child: icon ?? CustomIcons.rubProject,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            reversed ? _icon() : _coin(_theme),
            if (offset != null) SizedBox(width: offset),
            reversed ? _coin(_theme) : _icon()
          ],
        ),
        if (description != null && reversed == false)
          Text(
            description ?? '',
            style: _theme.textTheme.caption!
                .copyWith(fontSize: 12, color: AppColor.coinDescription),
          )
      ],
    );
  }
}
