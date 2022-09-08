import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';

class CustomNavBar extends StatefulWidget {
  /// Функция для отлова индекса и передачи в pageController
  final Function? onTap;

  const CustomNavBar({Key? key, this.onTap}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 1;
  final Map<String, String> _items = {
    'Главная': 'home',
    'Задания': 'tasks',
    'Новости': 'news',
    'Призы': 'prizes'
  };

  /// List с values итемов
  List<String> _typeIconItem() {
    return _items.entries.map((e) => e.value).toList();
  }

  /// List с ключами итемов
  List<String> _typeStringItem() {
    return _items.entries.map((e) => e.key).toList();
  }

  /// Отображение элементов Навбара
  Column _itemSelect(
      {required String icon, required String text, required Color color}) {
    final ThemeData _theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 44,
          child: Image.asset('lib/assets/images/icons/$icon.png', color: color),
        ),
        const SizedBox(height: 7),
        Text(
          text,
          style: _theme.textTheme.caption!
              .copyWith(fontSize: 10, color: color, letterSpacing: 0.5),
        )
      ],
    );
  }

  /// Функция при нажатии на итем
  void _onTap(index) {
    _selectedIndex = (index + 1);
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _devicePadding = MediaQuery.of(context).padding.bottom;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(bottom: _devicePadding),
        height: 88 + _devicePadding,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColor.white, boxShadow: [
          BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 4,
              color: AppColor.black.withOpacity(0.1)),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              _items.entries.length,
              (index) => GestureDetector(
                  onTap: () => _onTap(index),
                  child: _itemSelect(
                      icon: _typeIconItem()[index],
                      text: _typeStringItem()[index].toUpperCase(),
                      color: _selectedIndex == (index + 1)
                          ? AppColor.htmlText
                          : AppColor.navbarIconDisabled))),
        ),
      ),
    );
  }
}
