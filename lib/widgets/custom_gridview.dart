import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomGridView extends StatelessWidget {
  /// Кол-во итемов
  final int? itemCount;

  /// Итембилдер для итемов
  final Widget Function(BuildContext, int) itemBuilder;

  /// Кол-во столбцов
  final int crossAxisCount;

  /// Горизонтальный маржин
  final double horizontalMargin;

  /// Вертикальный маржин
  final double verticalMargin;

  const CustomGridView(
      {Key? key,
      required this.itemBuilder,
      this.crossAxisCount = 2,
      this.itemCount,
      this.horizontalMargin = 6,
      this.verticalMargin = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemCount != null
        ? MasonryGridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: verticalMargin,
            crossAxisSpacing: horizontalMargin,
            itemCount: itemCount,
            crossAxisCount: crossAxisCount,
            itemBuilder: itemBuilder)
        : const SizedBox();
  }
}
