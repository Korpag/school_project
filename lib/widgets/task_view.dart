import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_project/blocs/task_bloc.dart';
import 'package:school_project/models/task.dart';
import 'package:school_project/services/project.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/theme/app_icons.dart';
import 'package:school_project/widgets/button.dart';
import 'package:school_project/widgets/custom_form.dart';
import 'package:school_project/widgets/description.dart';
import 'package:school_project/widgets/image_picker.dart';
import 'package:school_project/widgets/main_window.dart';
import 'package:school_project/widgets/qr_scanner.dart';
import 'package:school_project/widgets/time_counter.dart';

class TaskView extends StatefulWidget {
  final TaskClass task;

  /// Превью статус таска
  final String previewStatus;

  /// Контроллер pageView
  final PageController controller;

  /// Получаем значение индекса
  final int index;

  /// Длинна списока итемов
  final int itemCount;

  /// Функция на смену страницы
  final Function callback;

  const TaskView(
      {Key? key,
      required this.previewStatus,
      required this.index,
      required this.itemCount,
      required this.controller,
      required this.callback,
      required this.task})
      : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  String _text = '';
  bool _showFloatButton = false;
  XFile? _file;
  bool? _buttonPushed;
  List<Map<String, dynamic>>? _listCheckboxes;

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    const double _heightCircle = 30;
    final bool _check = widget.index == widget.itemCount ? false : true;
    int _index = widget.index;
    String _status =
        widget.task.report != null ? widget.task.report!.status! : '';
    return BlocProvider(
      create: (context) => TaskBloc(RepositoryProvider.of<TaskService>(context),
          id: widget.task.id)
        ..add(TaskLoadApiEvent()),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: _check &&
                  (_showFloatButton ||
                      widget.task.taskType == "type_checkboxes" ||
                      widget.task.taskType == "type_simple")
              ? Button.floating(
                  widgetIcon: RotatedBox(
                      quarterTurns: 2,
                      child: Transform.scale(
                          scale: 0.5, child: CustomIcons.backButton())),
                  onTap: () {
                    /// Отправка запросов с ответом
                    if (_file != null) {
                      TaskService()
                          .postImageTask(id: widget.task.id, xFile: _file);
                    } else {
                      TaskService().postTask(
                          id: widget.task.id,
                          textTask: _text,
                          buttonPushed: _buttonPushed,
                          checkboxes: _listCheckboxes);
                    }
                    widget.controller.animateToPage(++_index,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 500));
                    widget.callback();
                  })
              : null,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Верхняя линия, если это не первое задание
              if (_index != 0)
                _line(
                    height: !_check ? _height * 0.332 : _height * 0.0418,
                    width: _width,
                    color: _statusWidget(widget.previewStatus).first),

              /// Описание задания
              if (_check)
                Padding(
                  padding: const EdgeInsets.only(left: 17, right: 17, top: 22),
                  child: Description(
                    title: widget.task.title,
                    description: widget.task.description,
                  ),
                ),

              /// Интерактивная часть
              if (_check)
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 50, left: 14, right: 14),
                  child: _typeTask(
                      context: context,
                      comment: widget.task.report != null
                          ? widget.task.report!.comment
                          : null,
                      type: widget.task.taskType ?? '',
                      image: widget.task.report != null
                          ? widget.task.report!.photoUrl
                          : null,
                      titleButton: widget.task.button != null
                          ? widget.task.button!.title
                          : null,
                      checkBox: widget.task.checkboxes),
                ),

              /// нижняя линия, с текстом статуса задачи
              if (_check)
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Кружок с иконкой
                          Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: SizedBox(
                              height: _heightCircle,
                              width: _heightCircle,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color:
                                            AppColor.button.withOpacity(0.1)),
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _status == 'pending'
                                            ? AppColor.button
                                            : _statusWidget(_status).first),
                                    child: Center(
                                        child: Icon(
                                      _statusWidget(_status).last,
                                      color: AppColor.white,
                                      size: _heightCircle * 0.65,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          /// Линия вниз
                          Expanded(
                            child: _line(
                                height: null,
                                width: _width,
                                color: _statusWidget(_status).first),
                          ),
                        ],
                      ),

                      /// Текст со статусом
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Description(
                                colorTitle: AppColor.text,
                                title: _statusWidget(_status).elementAt(1),
                              ),
                              const SizedBox(height: 5),
                              TimeCounter(
                                  date: widget.task.dateOfFinishAcceptingReports
                                      .toString())
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              /// Окно поздравлений
              if (!_check)
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: 265,
                          child: Description(
                              textAlignCenter: true,
                              title: 'выполнено'.toUpperCase(),
                              colorTitle: AppColor.taskDone,
                              description:
                                  'Завершите выполнение нажатием на кнопку «завершить», спасибо за  ответы и хорошего дня'),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 6, bottom: 48),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Button.large(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainWindow()));
                              },
                              text: 'Завершить',
                              borderRadius: 25),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          )),
    );
  }

  /// Лист виджетов в зависимости от статуса таска
  List<dynamic> _statusWidget(String status) {
    switch (status) {
      case 'pending':
        return _verificationWidget;
      case 'accepted':
        return _doneWidget;
      case 'rejected':
        return _cancelWidget;
      default:
        return _waitWidget;
    }
  }

  /// Интерактивный виджет в зависимости от типа задания
  Widget _typeTask({
    required String type,
    required BuildContext context,
    List<CheckboxClass>? checkBox,
    String? comment,
    String? image,
    String? titleButton,
  }) {
    switch (type) {
      case 'type_write_text':
        return CustomForm.text(
            textController: TextEditingController()..text = comment ?? '',
            clearTap: () {
              _text = '';
              _showFloatButton = false;
              setState(() {});
            },
            onChanged: (String value) {
              if (value.isNotEmpty) {
                _showFloatButton = true;
              } else {
                _showFloatButton = false;
              }
              _text = value;
              setState(() {});
            },
            requiredValidator: true,
            autoValidateMode: AutovalidateMode.onUserInteraction);
      case 'type_follow_link':
        return Center(
          child: Column(
            children: [
              const SizedBox(
                  width: 240,
                  child: Description(
                      description:
                          'Нажмите сканировать, для того чтоб открыть камеру телефона для сканирования QR кода',
                      textAlignCenter: true,
                      fontSizeDescription: 11,
                      colorDescription: AppColor.disabledText)),
              const SizedBox(height: 10),
              Button.mini(
                  text: 'Сканировать',
                  borderRadius: 14,
                  horizontalPadding: 18,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QrScanner()));
                  })
            ],
          ),
        );
      case 'type_checkboxes':
        if (checkBox != null) {
          _listCheckboxes = List.generate(
              checkBox.length,
              (index) => {
                    "id": checkBox.map((e) => e.id).toList()[index],
                    "checked": false
                  });
          return Column(
            children: List.generate(checkBox.length, (index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: CustomForm.checkBox(
                      text: checkBox.map((e) => e.title).toList()[index],
                      onChanged: (value) {
                        _listCheckboxes![index]["checked"] = value;
                      }));
            }),
          );
        }
        return const SizedBox();
      case 'type_upload_file':
        return CustomImagePicker(
          image: image,
          onTap: (xFile) {
            _file = xFile;
            _showFloatButton = true;
            setState(() {});
          },
        );
      case 'type_push_button':
        return Center(
            child: Button.large(
                text: titleButton,
                onTap: () {
                  _showFloatButton = true;
                  _buttonPushed = true;
                  setState(() {});
                }));
      default:
        return const SizedBox();
    }
  }

  /// Виджет отображения линии
  Padding _line({double? height, required double width, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(left: 27),
      child: DecoratedBox(
        decoration: BoxDecoration(color: color),
        child: SizedBox(
          height: height,
          width: width * 0.0096,
        ),
      ),
    );
  }
}

/// Лист с виджетами для отсутствия статуса (wait)
final List<dynamic> _waitWidget = [
  AppColor.button.withOpacity(0.1),
  'Задача в процессе выполнения',
  Icons.lightbulb
];

/// Лист с виджетами для статуса В обработке
final List<dynamic> _verificationWidget = [
  AppColor.button.withOpacity(0.1),
  'Задача отправлена на проверку учителем/модератором',
  Icons.more_horiz
];

/// Лист с виджетами для статуса Выполнено
final List<dynamic> _doneWidget = [
  AppColor.taskDone,
  'Задача проверена',
  Icons.check
];

/// Лист с виджетами для статуса Отклонено
final List<dynamic> _cancelWidget = [
  AppColor.taskCancel,
  'Задача проверена',
  Icons.clear
];
