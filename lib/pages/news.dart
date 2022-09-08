import 'package:flutter/material.dart';
import 'package:school_project/models/news.dart';
import 'package:school_project/pages/project.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/custom_appbar.dart';
import 'package:school_project/widgets/description.dart';
import 'package:school_project/widgets/html_content.dart';
import 'package:school_project/widgets/label.dart';
import 'package:school_project/widgets/main_layout.dart';
import 'package:school_project/widgets/popup_window.dart';

class NewsPage extends StatefulWidget {
  final List<NewsElement> news;

  /// Индекс новости
  final int index;

  /// Нужен ли переход на проект
  final bool toProject;

  /// Нужна ли кнопка назад
  final bool backButton;

  const NewsPage(
      {Key? key,
      required this.index,
      this.toProject = false,
      this.backButton = true,
      required this.news})
      : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  /// List с values итемов
  List<Color> _valuesItems(Map<String, Color> items) {
    return items.entries.map((e) => e.value).toList();
  }

  List<String> _keyItems(Map<String, Color> items) {
    return items.entries.map((e) => e.key).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> _testData = {
      'Образование': AppColor.newsAppBar,
      'Саморазвитие': AppColor.imagePickerErrorGradientSecond,
      'Физика': AppColor.imagePickerErrorGradientFirst,
    };
    return MainLayout(
      appBar: CustomAppBar.news(
          topPaddingDevice: MediaQuery.of(context).padding.top,
          backButton: widget.backButton,
          url: widget.news.elementAt(widget.index).pictureUrl,
          title: widget.news.elementAt(widget.index).title),
      horizontalPadding: 12,
      verticalPadding: 25,
      heightClearSizedBox: 0.12,

      /// Настройки выезжаюего окна
      popUp: widget.toProject == true
          ? () => showModal(
              context: context,
              title: 'Интересно, не правда ли?',
              titleButton: 'Перейти к заданию',
              description:
                  'А теперь поспеши выполнить ряд заданий которые тебе подготовили и заработай монет на свой баланс. А там глядишь, обменяешь их на новенький питбайк!',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectPage(id: 1)));
              })
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Лист с лейблами
          // if (_item.tags != null)
          Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                  2,
                  // _item.tags!.length,
                  (index) => Label(
                        title: _keyItems(_testData)[index],
                        color: _valuesItems(_testData)[index],
                      ))),
          const SizedBox(height: 25),

          /// Заголовок новости
          Description(
              title: widget.news.elementAt(widget.index).title,
              fontSizeTitle: 20),
          const SizedBox(height: 9),

          /// Html контекнт
          HtmlContent(
            data: widget.news.elementAt(widget.index).description,
          ),
        ],
      ),
    );
  }
}
