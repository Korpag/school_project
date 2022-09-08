import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:school_project/models/news.dart';
import 'package:school_project/pages/news.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/description.dart';
import 'package:flutter/services.dart';

/// Обертка для страницы новостей, позволяет нам получить необходимую анимацию появления новой новости.
class NewsWindow extends StatefulWidget {
  final List<NewsElement> news;
  final bool backButton;
  final bool toProject;
  final int id;

  const NewsWindow(
      {Key? key,
      required this.news,
      required this.id,
      this.backButton = true,
      this.toProject = false})
      : super(key: key);

  @override
  State<NewsWindow> createState() => _NewsWindowState();
}

class _NewsWindowState extends State<NewsWindow> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return widget.toProject != true
        ? PageView.builder(
            controller: _controller,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.news.length,
            itemBuilder: (BuildContext context, int index) {
              bool _check = index >= widget.news.length - 1 ? true : false;
              return _FetchMoreIndicator(
                maxIndex: _check,
                image: _check ? null : widget.news[index + 1].pictureUrl,
                nextTitle: _check ? null : widget.news[index + 1].title,
                onAction: () {
                  _controller.animateToPage(++index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                child: NewsPage(
                    index: index,
                    backButton: widget.backButton,
                    news: widget.news,
                    toProject: widget.toProject),
              );
            })

        /// Для новостей с переходом на проект по прочтению
        : PageView.builder(
            controller: _controller,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.news.length,
            itemBuilder: (BuildContext context, int index) {
              return NewsPage(
                  index: index,
                  backButton: widget.backButton,
                  news: widget.news,
                  toProject: widget.toProject);
            });
  }
}

/// Виджет рефреш индикатора новой новости
class _FetchMoreIndicator extends StatelessWidget {
  final Widget child;

  /// Колбек на рефреш
  final VoidCallback onAction;

  /// Строка для картинки след новости
  final String? image;

  /// Строка для заголовка след новости
  final String? nextTitle;

  /// Провекра на максимальный индекс
  final bool maxIndex;

  const _FetchMoreIndicator(
      {Key? key,
      required this.child,
      required this.onAction,
      this.image,
      this.nextTitle,
      required this.maxIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const height = 170.0;
    return Scaffold(
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          HapticFeedback.mediumImpact();
          HapticFeedback.mediumImpact();
          if (!maxIndex) {
            onAction();
          }
        },
        reversed: true,
        trailingScrollIndicatorVisible: false,
        leadingScrollIndicatorVisible: true,
        child: child,
        builder: (
          BuildContext context,
          Widget child,
          IndicatorController controller,
        ) {
          return AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                final dy = controller.value.clamp(0.0, 1.25) *
                    -(height - (height * 0.25));
                return Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(0.0, dy),
                      child: child,
                    ),
                    Positioned(
                      bottom: -height,
                      left: 0,
                      right: 0,
                      height: height,
                      child: Container(
                          transform: Matrix4.translationValues(0.0, dy, 0.0),
                          constraints: const BoxConstraints.expand(),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: controller.isLoading
                                    ? Container(
                                        margin: const EdgeInsets.all(20),
                                        child: const CircularProgressIndicator(
                                          color: AppColor.newsAppBarText,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : !maxIndex
                                        ? ClipOval(
                                            child: Image.network(image!,
                                                fit: BoxFit.cover))
                                        : null,
                              ),
                              const SizedBox(height: 10),
                              Description(
                                  title: controller.isLoading
                                      ? 'Загружаем...'
                                      : !maxIndex
                                          ? nextTitle
                                          : 'Новостей больше нет',
                                  textAlignCenter: true,
                                  maxLinesTitle: 2,
                                  colorTitle: AppColor.newsAppBar),
                              const SizedBox(height: 20),
                            ],
                          )),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
