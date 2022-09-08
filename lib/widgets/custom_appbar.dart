import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/theme/app_image.dart';
import 'package:school_project/widgets/button.dart';
import 'package:school_project/widgets/get_text_from_number.dart';
import 'package:school_project/widgets/progress_bar.dart';
import 'package:school_project/widgets/coin.dart';
import 'package:school_project/widgets/description.dart';
import 'package:school_project/widgets/favourites.dart';
import 'package:school_project/theme/app_icons.dart';

abstract class CustomAppBar {
  /// AppBar для главной
  static main(
      {required double topPaddingDevice,
      String? url,
      String? name,
      String? countCoin,
      String? countSticker}) {
    return _Main(
        topPaddingDevice: topPaddingDevice,
        url: url,
        name: name,
        countCoin: countCoin,
        countSticker: countSticker);
  }

  /// AppBar для проектов
  static project(
      {required double topPaddingDevice,
      String? url,
      String? count,
      bool? selected,
      Function()? onTapFavourites,
      String descriptionCoin = "на баланс"}) {
    return _Project(
        topPaddingDevice: topPaddingDevice,
        url: url,
        count: count,
        selected: selected,
        onTap: onTapFavourites,
        descriptionCoin: descriptionCoin);
  }

  /// AppBar для новостей
  static news({required double topPaddingDevice, String? url, String? title, bool backButton = true}) {
    return _News(topPaddingDevice: topPaddingDevice, url: url, title: title, backButton: backButton);
  }

  /// Стандартный AppBar
  static mini(
      {bool progressBar = false, int? count, bool? moderator, int? countDone}) {
    return _Default(
        height: 64,
        progressBar: progressBar,
        count: count,
        countDone: countDone,
        moderator: moderator);
  }
}

class _Project extends SliverPersistentHeaderDelegate {
  final double topPaddingDevice;
  final String? url;
  final String? count;
  final String? descriptionCoin;
  final bool? selected;
  final Function? onTap;

  const _Project({
    this.topPaddingDevice = 0,
    this.url,
    this.count,
    this.descriptionCoin,
    this.selected,
    this.onTap,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        /// Фото проекта
        if (url != null)
          Image.network(
            url!,
            fit: BoxFit.cover,
          ),

        /// Контейнер подложка
        Opacity(
          opacity: shrinkOffset / (maxExtent),
          child: DecoratedBox(
            decoration: BoxDecoration(
                image: const DecorationImage(
                    opacity: 0.03,
                    fit: BoxFit.cover,
                    image: AssetImage(CustomImage.background)),
                gradient: _gradient(list: [
                  AppColor.projectAppBarGradientFirst,
                  AppColor.projectAppBarGradientSecond,
                ])),
          ),
        ),

        /// Фото проекта маленькое
        if (shrinkOffset > maxExtent * 0.9 && url != null)
          _position(
              alignment: Alignment.centerRight,
              rightPadding: 78,
              topPadding: 5 + topPaddingDevice,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    url!,
                    fit: BoxFit.cover,
                  ),
                ),
              )),

        /// Кнопка избранного
        if (shrinkOffset > maxExtent * 0.9)
          _position(
              alignment: Alignment.centerRight,
              topPadding: 5 + topPaddingDevice,
              rightPadding: 14,
              child: Favourites(selected: selected, onTap: onTap)),

        /// Кнопка назад
        _position(
            leftPadding: 14,
            topPadding: 20 + topPaddingDevice,
            child: Button.back(onTap: () {
              Navigator.pop(context);
            })),

        /// Баланс
        if (shrinkOffset > maxExtent * 0.9)
          _position(
              alignment: Alignment.centerLeft,
              leftPadding: 68,
              topPadding: topPaddingDevice,
              child: Coin(
                  count: count,
                  description: descriptionCoin,
                  offset: 3,
                  iconSize: 26))
      ],
    );
  }

  @override
  double get maxExtent => 340 + topPaddingDevice;

  @override
  double get minExtent => 64 + topPaddingDevice;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _News extends SliverPersistentHeaderDelegate {
  final double topPaddingDevice;
  final String? url;
  final String? title;
  final bool backButton;

  const _News({
    this.topPaddingDevice = 0,
    this.url,
    this.title,
    this.backButton = true
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final _percent = shrinkOffset / maxExtent;
    final _red = 99 * _percent;
    final _green = 32 * _percent;
    return Stack(
      fit: StackFit.expand,
      children: [
        /// Фото проекта
        if (url != null)
          Image.network(
            url!,
            fit: BoxFit.cover,
          ),

        /// Контейнер подложка
        Opacity(
          opacity: _percent,
          child: DecoratedBox(
            decoration: BoxDecoration(
                image: const DecorationImage(
                    opacity: 0.03,
                    fit: BoxFit.cover,
                    image: AssetImage(CustomImage.background)),
                gradient: _gradient(list: [
                  AppColor.newsAppBarText,
                  AppColor.newsAppBar,
                ])),
          ),
        ),

        /// Фото проекта маленькое
        if (shrinkOffset > maxExtent * 0.9 && url != null)
          _position(
              alignment: Alignment.centerLeft,
              leftPadding: 65,
              topPadding: 5 + topPaddingDevice,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    url!,
                    fit: BoxFit.cover,
                  ),
                ),
              )),

        /// Кнопка назад
        if (backButton == true)
        _position(
            leftPadding: 14,
            topPadding: 20 + topPaddingDevice,
            child: Button.back(
                onTap: () {
                  Navigator.pop(context);
                },

                /// Динамическое изменение цвета кнопки
                color: Color.fromRGBO(
                    255 - _red.toInt(), 255 - _green.toInt(), 255, 1))),

        /// Заголовок новости
        if (shrinkOffset > maxExtent * 0.9)
          _position(
              topPadding: topPaddingDevice,
              leftPadding: 149,
              alignment: Alignment.centerRight,
              rightPadding: 14,
              bottomPadding: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Description(
                      title: title, colorTitle: AppColor.newsAppBarText),
                ],
              )),
      ],
    );
  }

  @override
  double get maxExtent => 340 + topPaddingDevice;

  @override
  double get minExtent => 64 + topPaddingDevice;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _Default extends StatelessWidget {
  final double height;
  final bool progressBar;
  final int? count;
  final int? countDone;
  final bool? moderator;

  const _Default(
      {Key? key,
      required this.height,
      this.progressBar = false,
      this.count,
      this.countDone,
      this.moderator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deviceTopPadding = MediaQuery.of(context).padding.top;
    return Container(
      decoration: BoxDecoration(color: AppColor.white, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 4,
            color: AppColor.black.withOpacity(0.1))
      ]),
      height: height + _deviceTopPadding,
      padding: EdgeInsets.only(
          top: _deviceTopPadding + 5, bottom: 5, left: 20, right: 20),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button(
                text: 'НАЗАД',
                horizontalPadding: 0,
                fontSize: 12,
                colorText: AppColor.button,
                fillColor: false,
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          if (progressBar)
            Center(
                child: ProgressBar(
              count: count,
              countDone: countDone,
              moderator: moderator,
            )),
        ],
      ),
    );
  }
}

class _Main extends SliverPersistentHeaderDelegate {
  final double topPaddingDevice;
  final String? url;
  final String? name;
  final String? countCoin;
  final String? countSticker;

  const _Main(
      {this.topPaddingDevice = 0,
      this.url,
      this.name,
      this.countCoin,
      this.countSticker});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final _percent = shrinkOffset / maxExtent;
    final _radiusPercent = 12 - 12 * _percent;
    final _borderRadius = Radius.circular(_radiusPercent);
    final double _imageOpacity = (_percent * 9) > 1 ? 1 : (_percent * 9);
    return Stack(
      fit: StackFit.expand,
      children: [
        /// Контейнер подложка
        DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: _borderRadius, bottomRight: _borderRadius),
              image: const DecorationImage(
                  opacity: 0.03,
                  fit: BoxFit.cover,
                  image: AssetImage(CustomImage.background)),
              gradient: _gradient(list: [
                AppColor.projectAppBarGradientFirst,
                AppColor.projectAppBarGradientSecond,
              ])),
        ),

        /// Фото проекта
        if (url != null)
          Opacity(
            opacity: 0.1 * _percent,
            child: Image.network(
              url!,
              fit: BoxFit.cover,
            ),
          ),

        /// Имя TODO если такое отображение будет одобрено, подправить чуток на телефонах с шириной меньше 350пикселей
        _position(
            bottomPadding: 0,
            topPadding: topPaddingDevice + (30 - 30 * _percent),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 160,
                  child: Description(
                      textAlignCenter: true,
                      maxLinesDescription: 2,
                      title: name,
                      fontSizeTitle: 18),
                ),
              ],
            )),

        /// Баланс аккаунта
        _position(
          topPadding: topPaddingDevice,
          alignment: Alignment.bottomCenter,
          bottomPadding: 14,
          leftPadding: 20,
          rightPadding: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Coin(
                  reversed: true,
                  offset: 7,
                  description: getTextFromNumber(
                      number: countCoin ?? "0",
                      one: 'монета',
                      two: 'монеты',
                      five: 'монет'),
                  fontSize: 35 - 15 * _percent,
                  iconSize: 45 - 20 * _percent,
                  icon: CustomIcons.rub,
                  count: countCoin),
              Coin(
                reversed: true,
                offset: 7,
                description: getTextFromNumber(
                    number: countSticker ?? "0",
                    one: 'стикер',
                    two: 'стикера',
                    five: 'стикеров'),
                fontSize: 35 - 15 * _percent,
                iconSize: 50 - 20 * _percent,
                count: countSticker,
                icon: CustomIcons.sticker,
              ),
            ],
          ),
        ),

        /// Фото проекта маленькое
        if (url != null)
          Opacity(
            opacity: 1 - _imageOpacity,
            child: _position(
                alignment: Alignment.topCenter,
                topPadding: 50,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          url!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _errorBuilder(),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return _errorBuilder();
                          },
                        )),
                  ),
                )),
          ),
      ],
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 64 + topPaddingDevice;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

/// Общий настраиваемый градиент для AppBar
LinearGradient _gradient({required List<Color> list}) {
  return LinearGradient(
      begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: list);
}

/// Общий виджет позиционирования для AppBar
Align _position(
    {AlignmentGeometry alignment = Alignment.topLeft,
    double topPadding = 5,
    double bottomPadding = 5,
    double leftPadding = 0,
    double rightPadding = 0,
    required Widget child}) {
  return Align(
    alignment: alignment,
    child: Padding(
      padding: EdgeInsets.only(
          top: topPadding,
          left: leftPadding,
          right: rightPadding,
          bottom: bottomPadding),
      child: child,
    ),
  );
}

/// Индикатор для аватара
CircularProgressIndicator _errorBuilder() {
  return const CircularProgressIndicator(
      color: AppColor.projectAppBarGradientSecond);
}
