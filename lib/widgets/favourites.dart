import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/theme/app_icons.dart';

class Favourites extends StatefulWidget {
  /// Цвет выбранной иконки
  final Color selectedColor;

  /// Цвет невыбранной иконки
  final Color unselectedIcon;

  /// Булевая переменная для первоначального значания
  final bool? selected;

  /// Функция для запроса
  final Function? onTap;

  /// Размер иконки
  final double size;

  /// Нужна ли обводка
  final bool border;

  const Favourites(
      {Key? key,
      this.selectedColor = AppColor.favouritesStar,
      this.unselectedIcon = AppColor.white,
      this.selected,
      this.onTap,
      this.size = 23,
      this.border = false})
      : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected ?? false;
  }

  /// Функция нажатия на иконку
  void _onTap() {
    _selected = !_selected;
    if (widget.onTap != null) {
      widget.onTap!();
    }
    setState(() {});
  }

  /// Иконка
  SizedBox _icon({required Color color, double size = 0}) {
    return SizedBox(
      height: widget.size - size,
      width: widget.size - size,
      child: CustomIcons.favourite(
        color: _selected ? widget.selectedColor : color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onTap,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            if (widget.border) _icon(color: AppColor.favouritesStarThin),
            _icon(color: widget.unselectedIcon, size: widget.border ? 2 : 0)
          ],
        ));
  }
}
