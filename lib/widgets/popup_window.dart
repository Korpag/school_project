import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/button.dart';
import 'package:school_project/widgets/description.dart';

void showModal(
    {required BuildContext context,
    String? title,
    String? description,
    Function()? onTap,
    String titleButton = 'Приступить к проверке'}) async {
  await showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 23),
          decoration: _boxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Описание
              Description(
                title: title,
                description: description,
                maxLinesDescription: 8,
              ),
              const SizedBox(height: 20),

              /// Кнопка
              Button.large(
                  text: titleButton,
                  borderRadius: 14,
                  horizontalPadding: 36,
                  onTap: onTap)
            ],
          ),
        );
      });
}

/// Декорации к всплывающему окну
BoxDecoration _boxDecoration() {
  return BoxDecoration(
      color: AppColor.white,
      boxShadow: [
        BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, -2),
            color: AppColor.black.withOpacity(0.1))
      ],
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32), topRight: Radius.circular(32)));
}
