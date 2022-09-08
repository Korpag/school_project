import 'package:flutter/material.dart';
import 'package:school_project/theme/app_image.dart';
import 'package:school_project/widgets/description.dart';

class NewsCard extends StatelessWidget {
  /// Что произойдет если нажать на карточку
  final Function()? onTap;

  /// Строка для изображения
  final String? image;

  /// Описание под картинкой
  final String? description;

  const NewsCard({Key? key, this.onTap, this.image, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 182,
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FadeInImage(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder:
                              const AssetImage(CustomImage.placeholder),
                          image: NetworkImage(image!)),
                    )
                  : null,
            ),
            const SizedBox(height: 13),
            Description(description: description, maxLinesDescription: 2)
          ],
        ),
      ),
    );
  }
}
