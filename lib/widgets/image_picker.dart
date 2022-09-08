import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/button.dart';
import 'package:school_project/widgets/description.dart';

class CustomImagePicker extends StatefulWidget {
  final Function(XFile)? onTap;

  /// Для ситуаций, когда мы, например, возвращаемся на ранее выполненый таск (изображение уже было отправленно)
  final String? image;

  const CustomImagePicker({Key? key, this.onTap, this.image}) : super(key: key);

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  XFile? _image;
  bool _searchImage = false;
  bool _errorSize = false;
  String _status = 'Загрузить';

  Future<void> _pickImage() async {
    Future.delayed(const Duration(milliseconds: 600)).then((value) {
      /// События при нажатии на загрузить
      _searchImage = true;
      _errorSize = false;
      _status = 'Загрузка...';
      setState(() {});
    });

    try {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 100);

      /// Если загрузилось
      if (image != null) {
        _image = image;
        if (File(_image!.path).lengthSync() > 5242880) {
          //TODO Добавить обработку ошибки на фото менее 1024х768, если необходимо
          _errorSize = true;
          _status = 'Ошибка загрузки';
        }
        setState(() {});

        /// Если отменена загрузка или пришел null
      } else {
        setState(() {
          _searchImage = false;
          _status = 'Загрузить';
        });
      }

      /// Функция для передачи изображения
      if (widget.onTap != null) {
        await widget.onTap!(image!);
      }
    } on Exception catch (e) {
      print('Failed to pick image $e');
    }
  }

  /// Декорация для контейнера с иконкой
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
        shape: BoxShape.circle,
        color: !_searchImage ? AppColor.disabledText.withOpacity(0.5) : null,
        boxShadow: !_searchImage
            ? null
            : [
                BoxShadow(
                    blurRadius: 6,
                    color: AppColor.imagePickerShadow.withOpacity(0.4))
              ],
        gradient: !_searchImage
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: !_errorSize
                    ? [
                        AppColor.imagePickerGradientFirst,
                        AppColor.imagePickerGradientSecond,
                      ]
                    : [
                        AppColor.imagePickerErrorGradientFirst,
                        AppColor.imagePickerErrorGradientSecond,
                      ]));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    const double _height = 65;
    return (_image != null && _errorSize != true) ||
            widget.image !=
                null // TODO добавить потом сюда еще одно исключение, чтобы не отображалось изображение, пока не загрузиться фото

        /// Отображение выбранного изображения
        ? Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: widget.image != null
                      ? Image.network(
                          widget.image!,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 9),
              if (widget.image == null)
                GestureDetector(
                  onTap: () async {
                    await _pickImage();
                  },
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Если хотите выбрать другое фото, нажмите ',
                          style: _theme.textTheme.caption!
                              .copyWith(fontSize: 12, color: AppColor.text),
                          children: [
                            TextSpan(
                                text: 'выбрать фото',
                                style: _theme.textTheme.caption!.copyWith(
                                    fontSize: 12,
                                    color: AppColor.imagePickerShadow))
                          ])),
                ),
            ],
          )

        /// Отображение выбора изображения
        : Column(
            children: [
              /// Кружок с иконкой
              SizedBox(
                  height: _height,
                  width: _height,
                  child: DecoratedBox(
                    decoration: _boxDecoration(),
                    child: Icon(
                      Icons.photo_camera,
                      color: _searchImage
                          ? AppColor.white
                          : AppColor.htmlText.withOpacity(0.3),
                      size: _height * 0.6,
                    ),
                  )),

              /// Инструкция
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Description(
                  textAlignCenter: true,
                  fontSizeDescription: 11,
                  colorTitle: AppColor.htmlText,
                  title: _status.toUpperCase(),
                  description:
                      'Поддерживаются изображения формата png, jpeg. Разрешение должно быть не менее 1024х768. Размер файла не превышать 5 Мб.',
                ),
              ),

              /// Предупреждение, при ошибке
              if (_errorSize)
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 60, right: 60),
                    child: Text(
                        'Превышен размер файла, для кого разработчик старался и писал?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 11, color: AppColor.error))),

              /// Кнопка пикера
              Button.mini(
                  text: 'Обзор',
                  borderRadius: 14,
                  onTap: () async {
                    await _pickImage();
                    // File(_image.)
                  })
            ],
          );
  }
}
