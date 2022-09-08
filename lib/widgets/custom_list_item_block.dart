import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/button.dart';

class CustomListBlock extends StatelessWidget {
  /// Заголовок Лист блока
  final String? title;

  /// цвет заголовка
  final Color? titleColor;

  /// Высота item
  final double? height;

  /// Привязка страниц. Свободный скролл или же каждая страница будет фиксироваться
  final bool pageSnapping;

  /// double переменная для контроля отображаемого кол-ва итемов на экране. значение от 0 до 1, где 1 это 1 итем.
  final double viewportFraction;

  /// Кол-во итемов в листе
  final int countList;

  /// Итембилдер для итемов
  final Widget Function(BuildContext, int) itemBuilder;

  /// Тип виджета. Если нужен вертикальный List, то пишем 'vertical'.
  final String type;

  /// Функция для кнопки больше челленджей, если нужна
  final Function()? moreChallengeTap;

  /// Выделяемая высота под итемы в вертикальном листе
  final double? heightVerticalList;

  const CustomListBlock(
      {Key? key,
      this.title,
      this.titleColor,
      this.height,
      this.pageSnapping = true,
      this.viewportFraction = 1,
      required this.countList,
      required this.itemBuilder,
      this.type = 'horizontal',
      this.moreChallengeTap,
      this.heightVerticalList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            /// Виджет заголовка
            if (title != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TitleListBlock(
                    theme: _theme,
                    title: title ?? 'Заголовок',
                    titleColor: titleColor,
                  ),
                  if (moreChallengeTap != null)
                  Button.mini(
                      text: 'Показать все',
                      horizontalPadding: 12,
                      fillColor: false,
                      colorText: AppColor.button,
                      onTap: moreChallengeTap)
                ],
              ),

            if (title != null) const SizedBox(height: 29),

            /// Отобрадение в зависимости от типа
            type == 'vertical'
                ? _VerticalListBlock(
                    itemBuilder: itemBuilder,
                    countList: countList,
                    heightVerticalList: heightVerticalList,
                  )
                :

                /// Настраиваемый PageView
                _PageViewCustom(
                    viewportFraction: viewportFraction,
                    pageSnapping: pageSnapping,
                    countList: countList,
                    height: height,
                    itemBuilder: itemBuilder,
                  )
          ],
        ),
      ],
    );
  }
}

class _PageViewCustom extends StatefulWidget {
  final double viewportFraction;
  final double? height;
  final bool pageSnapping;
  final int countList;
  final Widget Function(BuildContext, int) itemBuilder;

  const _PageViewCustom(
      {Key? key,
      required this.viewportFraction,
      this.height,
      required this.pageSnapping,
      required this.countList,
      required this.itemBuilder})
      : super(key: key);

  @override
  State<_PageViewCustom> createState() => _PageViewCustomState();
}

class _PageViewCustomState extends State<_PageViewCustom> {
  PageController _pageController = PageController(viewportFraction: 1);
  double _viewportFraction = 1;

  @override
  void initState() {
    super.initState();
    _viewportFraction = widget.viewportFraction;
    _pageController = PageController(viewportFraction: _viewportFraction);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.countList > 0
        ? SizedBox(
            height: widget.height ?? 138,
            child: PageView.builder(
                pageSnapping: widget.pageSnapping,
                padEnds: false,
                controller: _pageController,
                itemCount: widget.countList,
                itemBuilder: widget.itemBuilder),
          )
        : const _EmptyText();
  }
}

class _VerticalListBlock extends StatelessWidget {
  /// Кол-во итемов в листе
  final int countList;

  /// Билдер для итемов
  final Widget Function(BuildContext, int) itemBuilder;

  /// Высота выделяемая под итемы
  final double? heightVerticalList;

  const _VerticalListBlock(
      {Key? key,
      required this.countList,
      required this.itemBuilder,
      this.heightVerticalList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return countList > 0
        ? SizedBox(
            height: heightVerticalList ??
                (countList > 4 ? 424 : 106 * countList.toDouble()),
            child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: itemBuilder,
                separatorBuilder: (ctx, index) => const SizedBox(height: 20),
                itemCount: countList < 4 ? countList : 4),
          )
        : const _EmptyText();
  }
}

class _TitleListBlock extends StatelessWidget {
  final ThemeData theme;
  final String title;
  final Color? titleColor;

  const _TitleListBlock(
      {Key? key, required this.theme, required this.title, this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          const SizedBox(width: 12),
          Container(
            constraints: const BoxConstraints(maxWidth: 235),
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.overline!.copyWith(
                    fontSize: 16, color: titleColor ?? AppColor.coinBlack)),
          ),
        ],
      ),
    );
  }
}

class _EmptyText extends StatelessWidget {
  const _EmptyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Center(
        child: Text('К сожалению, ничего нет',
            style:
                _theme.textTheme.button!.copyWith(color: AppColor.htmlText)));
  }
}
