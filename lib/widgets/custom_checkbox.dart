import 'package:flutter/cupertino.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:school_project/utils/validators.dart';

class CustomCheckBox extends StatefulWidget {
  /// Сопровождающий текст
  final String? text;

  /// Нужен ли стандартный валидатор на заполненность
  final bool? needStandardValidator;

  /// Дополнительный валидатор после стандартных, если требуется(запрос)
  final Future<String?>? Function(bool)? onReady;

  /// Булевая переменная для стартового значения
  final bool? value;

  /// Функция на изменение значения
  final Function? onChanged;

  /// Только для проверки
  final bool? moderator;

  const CustomCheckBox(
      {Key? key,
      this.text,
      this.needStandardValidator,
      this.onReady,
      this.value,
      this.onChanged, this.moderator})
      : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _check = false;
  bool _loader = false;
  String? _textError;

  /// Функция по нажатию на кнопку
  void _onChanged(value, state) async {
    setState(() {
      _loader = true;
    });
    await getBoolValidator(
            value: !_check,
            onReady: widget.onReady,
            requiredValidator: widget.needStandardValidator)
        .then((result) {
      _textError = result;
      state.didChange(value);
      _check = value!;
      _loader = false;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  /// CheckBox виджет
  Container _checkbox(state, size) {
    bool _moderator = widget.moderator == true ? true : false;
    const LinearGradient _gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColor.checkboxGradientFirstColor,
          AppColor.checkboxGradientSecondColor,
        ]);
    return Container(
      decoration: BoxDecoration(
        color: _moderator ? (state.value ? AppColor.htmlText : AppColor.disabledText) : null,
          borderRadius: BorderRadius.circular(2), gradient: !_moderator ? _gradient : null),
      height: size,
      width: size,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: state.value ? (_moderator ? AppColor.htmlText : null) : AppColor.white,
            gradient: state.value ? (!_moderator ? _gradient : null) : null),
        child: Checkbox(
            activeColor: Colors.transparent,
            value: state.value,
            onChanged: (value) => widget.moderator != true ? _onChanged(value, state) : null),
      ),
    );
  }

  /// Лоадер
  SizedBox _loaderWidget(size) {
    return SizedBox(
        width: size, height: size, child: const CupertinoActivityIndicator());
  }

  /// Текст
  Flexible _text(theme) {
    return Flexible(
        child: Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(widget.text ?? '',
          style: theme.textTheme.caption!.copyWith(color: AppColor.htmlText)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    const double _size = 24;
    final ThemeData _theme = Theme.of(context);
    return FormField<bool>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: widget.value ?? false,
        validator: (_) => _textError,
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (_loader == false) _checkbox(state, _size),
                  if (_loader == true && widget.onReady != null)
                    _loaderWidget(_size),
                  if (widget.text != null) _text(_theme),
                ],
              ),
              if (state.hasError) _ErrorWidget(theme: _theme, state: state)
            ],
          );
        });
  }
}

/// Виджет отображения ошибки
class _ErrorWidget extends StatelessWidget {
  final ThemeData theme;
  final FormFieldState<bool>? state;

  const _ErrorWidget({Key? key, required this.theme, this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(top: 5),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColor.error, width: 2))),
      child: Row(
        children: [
          Flexible(
            child: Text(
              state?.errorText ?? '',
              style: theme.textTheme.caption!
                  .copyWith(color: AppColor.error, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
