import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/blocs/task_bloc.dart';
import 'package:school_project/models/report.dart';
import 'package:school_project/models/task.dart';
import 'package:school_project/services/project.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/theme/app_icons.dart';
import 'package:school_project/widgets/button.dart';
import 'package:school_project/widgets/custom_form.dart';
import 'package:school_project/widgets/custom_shimmer.dart';
import 'package:school_project/widgets/description.dart';
import 'package:school_project/widgets/time_counter.dart';

class TaskViewModeration extends StatefulWidget {
  /// Контроллер pageView
  final PageController controller;

  /// Получаем значение индекса
  final int index;

  /// Длинна списока итемов
  final int itemCount;

  /// Получаем id таска
  final int? taskId;

  /// Функция на смену страницы
  final Function callback;

  /// Тип таска
  final String? typeTask;

  const TaskViewModeration(
      {Key? key,
      required this.controller,
      required this.index,
      required this.itemCount,
      this.taskId,
      required this.callback,
      this.typeTask})
      : super(key: key);

  @override
  State<TaskViewModeration> createState() => _TaskViewModerationState();
}

class _TaskViewModerationState extends State<TaskViewModeration> {
  bool _showTask = false;
  bool _loader = false;

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    const double _heightCircle = 30;
    final bool _check = widget.index == widget.itemCount ? false : true;
    int _index = widget.index;
    String _status = '';
    final bool _checkLastPageModerator = widget.index + 1 != widget.itemCount;
    return BlocProvider(
      create: (context) => TaskBloc(RepositoryProvider.of<TaskService>(context),
          id: widget.taskId)
        ..add(TaskLoadApiEvent()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: _check && _checkLastPageModerator
            ? Button.floating(
                widgetIcon: RotatedBox(
                    quarterTurns: 2,
                    child: Transform.scale(
                        scale: 0.5, child: CustomIcons.backButton())),
                onTap: () {
                  widget.controller.animateToPage(++_index,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 500));

                  /// TODO требуются правки по логике колбека (для прогресс бара)
                  if (_status == "accepted" || _status == "rejected") {
                    widget.callback();
                  }
                })
            : null,
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadingState) {
              return CustomShimmer.taskWindow;
            }
            if (state is TaskLoadedState) {
              if (state.task.report != null) {
                _status = state.task.report!.status ?? '';
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Верхняя линия, если это не первое задание
                  if (widget.index != 0)
                    _line(
                        height: _height * 0.0418,
                        width: _width,
                        // TODO сюда нужно прокидывать цвет статуса прошлого таска
                        color: _statusWidget(_status).first),

                  /// Отображение задания от лица модератора
                  Padding(
                      padding: EdgeInsets.only(
                          left: 14,
                          top: 26,
                          right: 14,
                          bottom: widget.typeTask == 'type_write_text' ||
                                  widget.typeTask == 'type_follow_link'
                              ? 35
                              : 0),
                      child: !_showTask
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 22,
                                  child: Row(
                                    children: [
                                      Button.feedback(
                                          text: 'Развернуть задание',
                                          onTap: () async {
                                            _loader = true;
                                            setState(() {});
                                            // TODO временно для симуляции запроса
                                            await Future.delayed(
                                                    const Duration(seconds: 1))
                                                .then((value) {
                                              if (state.task.description !=
                                                  null) {
                                                _loader = false;
                                                _showTask = true;
                                                setState(() {});
                                              }
                                            });
                                          }),
                                      const SizedBox(width: 10),
                                      if (_loader)
                                        const CupertinoActivityIndicator()
                                    ],
                                  ),
                                ),
                                if (state.task.report != null)
                                  SizedBox(
                                      height:
                                          widget.typeTask != "type_checkboxes"
                                              ? 35
                                              : 15),
                                Description(
                                  description: state.task.report != null
                                      ? state.task.report!.comment
                                      : null,
                                )
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Description(
                                    title: 'Задание:',
                                    colorTitle: AppColor.disabledText,
                                    fontSizeTitle: 12,
                                    fontWeightTitle: FontWeight.w400,
                                    distanceBetweenItems: 25,
                                    description: state.task.description),
                                const SizedBox(height: 35),
                                if (state.task.report != null)
                                  Description(
                                      title: 'Ответ:',
                                      colorTitle: AppColor.disabledText,
                                      fontSizeTitle: 12,
                                      fontWeightTitle: FontWeight.w400,
                                      distanceBetweenItems: 25,
                                      description: state.task.report!.comment),
                                // const SizedBox(height: 35),
                              ],
                            )),

                  /// Интерактивная часть
                  if (_check)
                    Padding(
                      padding: widget.typeTask == 'type_upload_file' ||
                              widget.typeTask == 'type_checkboxes'
                          ? const EdgeInsets.only(
                              top: 0, bottom: 50, left: 14, right: 14)
                          : EdgeInsets.zero,
                      child: _typeTask(
                          type: state.task.taskType ?? '',
                          checkBox: state.task.checkboxes,
                          checkboxChecked: state.task.report != null
                              ? state.task.report!.checkboxes
                              : null,
                          image: state.task.report != null
                              ? state.task.report!.photoUrl
                              : null),
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
                                            color: AppColor.button
                                                .withOpacity(0.1)),
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
                              if (_checkLastPageModerator)
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Description(
                                    colorTitle: AppColor.text,
                                    title: state.task.moderated == false
                                        ? 'Данная задача проверена автоматически. Учитель не может ее модерировать'
                                        : 'Данная задача в процессе проверки учителем/модератором',
                                  ),
                                  const SizedBox(height: 5),
                                  TimeCounter(
                                      date: state
                                          .task.dateOfFinishAcceptingReports
                                          .toString()),
                                  if (_status == 'pending')
                                    const SizedBox(height: 20),
                                  if (_status == 'pending')

                                    ///TODO разобраться, почему иногда не обновляется статус.
                                    Wrap(
                                      runSpacing: 10,
                                      children: [
                                        Button.feedback(
                                            text: 'Принять ответ',
                                            onReady: () {
                                              if (state.task.report != null) {
                                                TaskService()
                                                    .postChangeStatusReport(
                                                        id: state
                                                            .task.report!.id,
                                                        newStatus: 'accepted');
                                              }
                                              if (_status != "accepted" ||
                                                  _status != "rejected") {
                                                widget.callback();
                                              }
                                              BlocProvider.of<TaskBloc>(context)
                                                  .add(TaskLoadApiEvent());
                                              widget.controller.animateToPage(
                                                  ++_index,
                                                  curve: Curves.easeInOut,
                                                  duration: const Duration(
                                                      milliseconds: 500));
                                            }),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: _separatingLine(),
                                        ),
                                        Button.feedback(
                                            text: 'Отклонить ответ',
                                            onReady: () {
                                              if (state.task.report != null) {
                                                TaskService()
                                                    .postChangeStatusReport(
                                                        id: state
                                                            .task.report!.id,
                                                        newStatus: 'rejected');
                                              }
                                              if (_status != "accepted" ||
                                                  _status != "rejected") {
                                                widget.callback();
                                              }
                                              BlocProvider.of<TaskBloc>(context)
                                                  .add(TaskLoadApiEvent());
                                              widget.controller.animateToPage(
                                                  ++_index,
                                                  curve: Curves.easeInOut,
                                                  duration: const Duration(
                                                      milliseconds: 500));
                                            }),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: _separatingLine(),
                                        ),
                                        Button.feedback(
                                            text: 'Комментарий',
                                            permission: false)
                                      ],
                                    )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
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
    List<CheckboxClass>? checkBox,
    List<CheckboxReport>? checkboxChecked,
    String? image,
  }) {
    switch (type) {
      case 'type_write_text':
        return const SizedBox();
      case 'type_follow_link':
        return const SizedBox();
      case 'type_checkboxes':
        if (checkBox != null) {
          return Column(
            children: List.generate(checkBox.length, (index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: CustomForm.checkBox(
                      text: checkBox.map((e) => e.title).toList()[index],
                      moderator: true,
                      value: checkboxChecked!
                          .map((e) => e.checked)
                          .toList()[index]));
            }),
          );
        }
        return const SizedBox();
      case 'type_upload_file':
        return image != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_showTask) const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Description(
                    description:
                        'Фото загруженное пользователем, имеет расширение JPEG, размер файла составляет 3.5 мб',
                    fontSizeDescription: 12,
                  )
                  // TODO узнать с чьей стороны будут приходить эти данные
                ],
              )
            : const SizedBox();
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

  /// Вертикальная разделяющая линия
  SizedBox _separatingLine() {
    return const SizedBox(
      height: 15,
      width: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(color: AppColor.text),
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

/// Лист с виджетами для статуса verification
final List<dynamic> _verificationWidget = [
  AppColor.button.withOpacity(0.1),
  'Задача отправлена на проверку учителем/модератором',
  Icons.more_horiz
];

/// Лист с виджетами для статуса done
final List<dynamic> _doneWidget = [
  AppColor.taskDone,
  'Задача проверена',
  Icons.check
];

/// Лист с виджетами для статуса cancel
final List<dynamic> _cancelWidget = [
  AppColor.taskCancel,
  'Задача проверена',
  Icons.clear
];
