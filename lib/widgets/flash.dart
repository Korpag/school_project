import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/button.dart';
import 'package:school_project/widgets/description.dart';

/// Добавить типы, как будет ясность.

class Flash extends StatefulWidget {
  /// Заголовок уведомления
  final String? title;

  /// Описание уведомления
  final String? description;

  /// Вертикальный маржин
  final double verticalMargin;

  /// Функция закрытия уведомления - По умолчанию уже закрывает
  final Function? onClose;

  /// Функция перехода по уведомлению
  final Function()? onRedirect;

  /// Нужна ли кнопка закрыть
  final bool close;

  /// Показывать ли уведомление
  final bool show;

  const Flash(
      {Key? key,
      this.title,
      this.description,
      this.verticalMargin = 28,
      this.onClose,
      this.onRedirect,
      this.close = false, this.show = true})
      : super(key: key);

  @override
  State<Flash> createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  bool _show = true;

  @override
  void initState() {
    super.initState();
    _show = widget.show;
  }

  void _onTap() {
    _show = false;
    if (widget.onClose != null) {
      widget.onClose!();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _show == true
        ? Container(
            margin: EdgeInsets.symmetric(
                horizontal: 12, vertical: widget.verticalMargin),
            padding:
                const EdgeInsets.only(top: 17, bottom: 12, left: 21, right: 21),
            decoration: BoxDecoration(
                color: AppColor.flash, borderRadius: BorderRadius.circular(12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.sms_outlined, size: 49),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Description(
                        title: widget.title,
                        description: widget.description,
                        distanceBetweenItems: 5,
                        maxLinesDescription: 6,
                      ),
                      if (widget.onRedirect != null || widget.close)
                        const SizedBox(height: 20),
                      Wrap(
                        children: [
                          if (widget.onRedirect != null)
                            Button.mini(
                                text: 'Перейти', onTap: widget.onRedirect),
                          if (widget.close || widget.onClose != null)
                            Button.mini(
                                text: 'Хорошо',
                                fillColor: false,
                                horizontalPadding:
                                    widget.onRedirect != null ? 22 : 0,
                                colorText: AppColor.button,
                                onTap: _onTap)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        : const SizedBox(height: 20);
  }
}
