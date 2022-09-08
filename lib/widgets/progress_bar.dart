import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';

class ProgressBar extends StatelessWidget {
  /// Кол-во заданий
  final int? count;

  /// Кол-во выполненных заданий
  final int? countDone;

  /// Если true, то показывает кол-во провереных заданий еще и текстом
  final bool? moderator;

  const ProgressBar({Key? key, this.count, this.countDone, this.moderator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    const double _width = 169;
    return Column(
      children: [
        Text(moderator == true ? 'Заданий проверено ${countDone ?? 1} из ${count ?? 10}' : 'Заданий выполнено',
            style: _theme.textTheme.headline1),
        const SizedBox(height: 6),
        Container(
          height: 19,
          width: _width,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: AppColor.disabledText,
              borderRadius: BorderRadius.circular(9.5)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _width / (count ?? 10) * (countDone ?? 1),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    AppColor.progressBarGradientFirstColor,
                    AppColor.progressBarGradientSecondColor
                  ])),
            ),
          ),
        )
      ],
    );
  }
}
