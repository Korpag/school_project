import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';

class Avatar extends StatelessWidget {
  /// Строка для аватара
  final String? image;

  /// Размеры аватара
  final double height;

  const Avatar({Key? key, this.height = 100, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.disabledText.withOpacity(0.2)),
        child: image != null

            /// Аватар
            ? ClipOval(
                child: Image.network(
                image!,
                fit: BoxFit.cover,

                /// Анимация загрузки изображения
                loadingBuilder: (BuildContext context, Widget image,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return image;
                  return SizedBox(
                    height: height,
                    child: const CircularProgressIndicator(
                      strokeWidth: 6,
                      backgroundColor: AppColor.disabledText,
                      color: AppColor.circularIndicatorColor,
                    ),
                  );
                },
              ))
            : null,
      ),
    );
  }
}
