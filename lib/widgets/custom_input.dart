import 'package:flutter/cupertino.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:school_project/widgets/text_match.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:school_project/utils/validators.dart';

class CustomInput extends StatefulWidget {
  /// Ключ, если необходим
  final Key? keyForm;

  /// Включена ли валидация, по умолчанию включена(кроме обычного text)
  final AutovalidateMode? autoValidateMode;

  /// Поле доступно только для чтения?
  final bool? readOnly;

  /// Тип клавиатуры
  final TextInputType? keyboardType;

  /// контроллер для текста
  final TextEditingController? textController;

  ///Функция на enter;
  final Function(String)? onSubmitted;

  ///Функция на изменение инпута;
  final Function? onChanged;

  /// Тип Form (text/email/password)
  final String? typeForm;

  /// Текст подсказки
  final String? hintText;

  /// Формат вводимого текста
  final TextInputFormatter? textInputFormatter;

  /// Обязательно ли поле к заполнению
  final bool? requiredValidator;

  /// Дополнительный валидатор после стандартных, если требуется(запрос)
  final Future<String?>? Function(String)? onReady;

  /// Нужен ли ассинхронный запрос на сервер
  final bool? needRequest;

  /// Нужен ли AutoComplete
  final List<String>? autoCompleteList;

  /// Функция вызываемая на кнопку удаления
  final Function? clearTap;

  const CustomInput(
      {Key? key,
      this.keyForm,
      this.autoValidateMode,
      this.readOnly,
      this.keyboardType,
      this.textController,
      this.onSubmitted,
      this.onChanged,
      this.typeForm,
      this.hintText,
      this.textInputFormatter,
      this.requiredValidator,
      this.onReady,
      this.needRequest,
      this.clearTap,
      this.autoCompleteList})
      : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  final DateFormat _formatter = DateFormat('dd.MM.yy');
  late TextEditingController _textController;
  bool _obscureText = false;
  bool _showClearIcon = false;
  bool? _loader;
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool _showDatePickerValue = false;
  String? _textError;
  DateTime _focusedDay = DateTime.now();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  Color _deActiveArrowColor = AppColor.disabledText;
  final FocusNode _myFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _textController = widget.textController ?? TextEditingController();
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _myFocus.dispose();
    super.dispose();
  }

  /// Кастомный DatePicker
  Container _showDatePicker(ThemeData theme) {
    const EdgeInsets _chevronPadding =
        EdgeInsets.symmetric(vertical: 2, horizontal: 3);
    const EdgeInsets _chevronMargin = EdgeInsets.zero;
    Icon _arrow(IconData icon, Color color) {
      return Icon(icon, size: 30, color: color);
    }

    final TextStyle _weekStyle =
        theme.textTheme.caption!.copyWith(fontSize: 11, color: AppColor.button);
    TextStyle _textStyleCalendar(
        {Color color = AppColor.button,
        FontWeight fontWeight = FontWeight.w400}) {
      return theme.textTheme.caption!
          .copyWith(fontSize: 12, color: color, fontWeight: fontWeight);
    }

    final _textStyleSelected = _textStyleCalendar(
        color: AppColor.projectAppBarGradientFirst,
        fontWeight: FontWeight.w700);

    /// Вызывается при смене месяца
    void _onPageChanged(value) {
      _focusedDay = value;
      if (value.month == DateTime.now().month) {
        _deActiveArrowColor = AppColor.disabledText;
      } else {
        _deActiveArrowColor = AppColor.button;
      }
      setState(() {});
    }

    /// Вызывается при выборе промежутка дат
    void _onRangeSelected(start, end, focusedDay) {
      setState(() {
        _focusedDay = focusedDay;
        _rangeStart = start;
        _rangeEnd = end;
        _rangeSelectionMode = RangeSelectionMode.toggledOn;
        if (_rangeStart != null && _rangeEnd != null) {
          _textController.text =
              '${_formatter.format(start).toString()}-${_formatter.format(end).toString()}';
        }
      });
    }

    /// Вызывается при выборе определенной даты
    void _onDaySelected(selectedDay, focusedDay) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        if (_selectedDay != null) {
          _textController.text = _formatter.format(_selectedDay!).toString();
        }
      });
    }

    return Container(
      padding: const EdgeInsets.only(right: 7, left: 7, bottom: 7),
      decoration: BoxDecoration(color: AppColor.white, boxShadow: [
        BoxShadow(
          color: AppColor.coinBlack.withOpacity(0.1),
          blurRadius: 2,
        )
      ]),
      child: TableCalendar(
          rowHeight: 24,
          daysOfWeekHeight: 24,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
              disabledTextStyle: _textStyleCalendar(),
              weekendTextStyle: _textStyleCalendar(),
              outsideTextStyle: _textStyleCalendar(),
              defaultTextStyle: _textStyleCalendar(),
              withinRangeTextStyle: _textStyleSelected,
              selectedTextStyle: _textStyleSelected,
              rangeEndTextStyle: _textStyleSelected,
              rangeStartTextStyle: _textStyleSelected,
              todayTextStyle: _textStyleCalendar(
                  color: AppColor.progressBarGradientFirstColor,
                  fontWeight: FontWeight.w700),
              todayDecoration: const BoxDecoration(),
              selectedDecoration: const BoxDecoration(),
              rangeEndDecoration: const BoxDecoration(),
              rangeStartDecoration: const BoxDecoration(),
              rangeHighlightColor: AppColor.button.withOpacity(0.1),
              isTodayHighlighted: true),
          daysOfWeekStyle: DaysOfWeekStyle(
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.2, color: AppColor.text))),
              weekdayStyle: _weekStyle,
              weekendStyle: _weekStyle),
          headerStyle: HeaderStyle(
              headerPadding: EdgeInsets.zero,
              titleTextFormatter: (value, dynamic) =>
                  '${DateFormat.MMMM('ru').format(value)} ${DateFormat.y('ru').format(value)}',
              titleCentered: true,
              formatButtonVisible: false,
              leftChevronPadding: _chevronPadding,
              rightChevronPadding: _chevronPadding,
              leftChevronMargin: _chevronMargin,
              rightChevronMargin: _chevronMargin,
              leftChevronIcon: _arrow(Icons.arrow_left, _deActiveArrowColor),
              rightChevronIcon: _arrow(Icons.arrow_right, AppColor.button),
              titleTextStyle: theme.textTheme.overline!
                  .copyWith(color: AppColor.text, fontSize: 16)),
          locale: 'ru',
          focusedDay: _focusedDay,
          firstDay: DateTime.now(),
          lastDay: DateTime(2050),
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          onPageChanged: _onPageChanged,
          rangeSelectionMode: _rangeSelectionMode,
          onRangeSelected:
              widget.typeForm == 'date_range' ? _onRangeSelected : null,
          onDaySelected: widget.typeForm == 'date' ? _onDaySelected : null),
    );
  }

  /// Виджет для отображения иконок в конце Input
  Row? _suffixIcon() {
    /// Универсальное тело для самой иконки
    InkWell _button({Function()? onTap, required IconData icon}) {
      return InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onTap ?? () {},
          child: Icon(icon, color: AppColor.text));
    }

    /// Строка с иконками
    Row _rowIcons(
        {bool needClearIcon = true,
        bool? needTypeIcon,
        IconData? iconType,
        Function()? onTapTypeIcon}) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_loader == true && widget.onReady != null)
            Row(
              children: const [
                SizedBox(
                    width: 12,
                    height: 12,
                    child: CupertinoActivityIndicator(color: AppColor.text)),
                SizedBox(width: 12)
              ],
            ),
          if (needClearIcon == true &&
              _textController.text.isNotEmpty &&
              _showClearIcon == true)
            _button(
                icon: Icons.clear,
                onTap: () {
                  if (widget.typeForm == 'date' ||
                      widget.typeForm == 'date_range') {
                    _selectedDay = null;
                    _rangeStart = null;
                    _rangeEnd = null;
                    _focusedDay = DateTime.now();
                  }
                  _textController.text = '';
                  if (widget.clearTap != null) {
                    widget.clearTap!();
                  }
                  setState(() {});
                }),
          if (widget.typeForm == 'password')
            _button(
                icon: _obscureText == true
                    ? Icons.remove_red_eye_rounded
                    : Icons.remove_red_eye_outlined,
                onTap: () {
                  _obscureText = !_obscureText;
                  setState(() {});
                }),
          if (needTypeIcon == true && _textController.text.isEmpty)
            _button(
                icon: iconType ?? Icons.date_range_outlined,
                onTap: onTapTypeIcon),
        ],
      );
    }

    return _rowIcons();
  }

  /// Формат вводимого текста
  TextInputFormatter getFormatter(String type) {
    switch (type) {
      case 'date_range':
        return MaskTextInputFormatter(
            mask: '##.##.## — ##.##.##',
            filter: {"#": RegExp(r'[0-9]')},
            initialText: _textController.text);
      case 'date':
        return MaskTextInputFormatter(
            mask: '##-##-##',
            filter: {"#": RegExp(r'[0-9]')},
            initialText: _textController.text);
      case 'phone':
        return MaskTextInputFormatter(
            mask: '+7 (###) ###-##-##',
            filter: {"#": RegExp(r'[0-9]')},
            initialText: _textController.text);
      case 'only_cyrillic':
        return FilteringTextInputFormatter.allow(RegExp('[а-яА-Я]'));
      default:
        return MaskTextInputFormatter();
    }
  }

  /// Ассинхронная функция по отслеживанию действий при использовани виджета
  void _onChanged(value) async {
    _loader = true;
    await getValidator(
            type: widget.typeForm,
            value: value,
            onReady: widget.onReady,
            needRequest: widget.needRequest,
            requiredValidator: widget.requiredValidator)
        .then((value) {
      setState(() {
        _loader = false;
        _textError = value;
      });
    });
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  /// Декорации для Инпута
  InputDecoration _inputDecoration(ThemeData theme) {
    return InputDecoration(
      errorText: null,
      labelText: widget.hintText ?? '',
      errorStyle: theme.textTheme.caption!
          .copyWith(color: AppColor.error, fontSize: 11),
      labelStyle: theme.textTheme.caption!.copyWith(color: AppColor.text),
      suffixIcon: Padding(
        padding: const EdgeInsets.only(top: 11),
        child: _suffixIcon(),
      ),
      suffixIconConstraints: const BoxConstraints(maxHeight: 20),
    );
  }

  /// Фокус, анфокус инпута
  void _logicFocus(value) {
    if (value) {
      _showClearIcon = true;
      if (widget.typeForm == 'date' || widget.typeForm == 'date_range') {
        _showDatePickerValue = true;
      }
      setState(() {});
    } else {
      _showClearIcon = false;
      if (widget.typeForm == 'date' || widget.typeForm == 'date_range') {
        _showDatePickerValue = false;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return FocusScope(
      onFocusChange: _logicFocus,
      child: Form(
        key: widget.keyForm,
        autovalidateMode:
            widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            if (_showDatePickerValue == true)
              Column(
                children: [_showDatePicker(_theme), const SizedBox(height: 10)],
              ),
            RawAutocomplete<String>(
              textEditingController: _textController,
              focusNode: _myFocus,
              onSelected: (value) {
                if (widget.onSubmitted != null &&
                    widget.autoCompleteList != null) {
                  widget.onSubmitted!(value);
                }
              },

              /// Функция возвращающая доступные объекты (если передать лист для autocomplete)
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (widget.autoCompleteList != null &&
                    textEditingValue.text != '') {
                  return widget.autoCompleteList!.where((String option) {
                    return option
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                } else {
                  return const Iterable<String>.empty();
                }
              },

              /// Отображение поля ввода
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  onFieldSubmitted: widget.onSubmitted ?? (_) {},
                  maxLines: widget.typeForm == 'password' ? 1 : null,
                  obscureText: widget.typeForm == 'password'
                      ? !_obscureText
                      : _obscureText,
                  controller: textEditingController,
                  focusNode: focusNode,
                  keyboardType: widget.keyboardType,
                  readOnly: widget.readOnly ?? false,
                  cursorColor: AppColor.text,
                  inputFormatters: [
                    widget.textInputFormatter ??
                        getFormatter(widget.typeForm ?? '')
                  ],
                  style: _theme.textTheme.caption!
                      .copyWith(color: AppColor.htmlText),
                  validator: (_) => _textError,
                  onChanged: _onChanged,
                  decoration: _inputDecoration(_theme),
                );
              },

              /// Отображение выпадающего списка для autocomplete
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                _style({Color? color}) {
                  return _theme.textTheme.caption!.copyWith(
                      color: AppColor.autoCompleteText, backgroundColor: color);
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, right: 24),
                        child: SizedBox(
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                                color: AppColor.autoCompleteFill),
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount:
                                    options.length > 5 ? 5 : options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option =
                                      options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 11),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: TextMatch(
                                                searchString:
                                                    _textController.text,
                                                content: option,
                                                style: _style(),
                                                matchStyle: _style(
                                                    color: AppColor.textMatch),
                                              )),
                                        ),
                                        LayoutBuilder(
                                          builder: (BuildContext context,
                                              BoxConstraints constraints) {
                                            return Flex(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                  (constraints.constrainWidth() /
                                                          (2.5 * 3))
                                                      .floor(),
                                                  (_) => const SizedBox(
                                                        width: 3,
                                                        height: 1,
                                                        child: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .autoCompleteText),
                                                        ),
                                                      )),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
