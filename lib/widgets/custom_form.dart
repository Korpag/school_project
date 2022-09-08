import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_project/widgets/custom_input.dart';
import 'package:school_project/widgets/custom_checkbox.dart';

abstract class CustomForm {
  /// Стандартный текстовый Input.
  static text(
      {Key? keyForm,
      AutovalidateMode? autoValidateMode,
      TextInputType? keyboardType,
      TextEditingController? textController,
      String? hintText,
      bool? readOnly,
      bool? requiredValidator,
      TextInputFormatter? textInputFormatter,
      Future<String?>? Function(String)? onReady,
      Function? onChanged,
      Function? clearTap,
      List<String>? autoCompleteList,
      Function(String)? onSubmitted,
      bool? needRequest}) {
    return CustomInput(
      keyForm: keyForm,
      autoValidateMode: autoValidateMode ?? AutovalidateMode.disabled,
      textInputFormatter: textInputFormatter,
      textController: textController,
      requiredValidator: requiredValidator,
      keyboardType: keyboardType,
      clearTap: clearTap,
      autoCompleteList: autoCompleteList,
      hintText: hintText ?? 'Введите текст:',
      typeForm: 'text',
      readOnly: readOnly,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      needRequest: needRequest,
      onReady: onReady,
    );
  }

  /// Input для ввода почты с соответствующими настройками
  static email(
      {Key? keyForm,
      TextEditingController? textController,
      Future<String?>? Function(String)? onReady,
      bool? needRequest}) {
    return CustomInput(
      keyForm: keyForm,
      textController: textController,
      hintText: 'Введите email (адрес электронной почты):',
      typeForm: 'email',
      onReady: onReady,
      needRequest: needRequest,
    );
  }

  /// Input для ввода телефона с соответствующими настройками
  static phone(
      {Key? keyForm,
      TextEditingController? textController,
      bool? requiredValidator,
      Future<String?>? Function(String)? onReady,
      bool? needRequest}) {
    return CustomInput(
      keyForm: keyForm,
      textController: textController,
      requiredValidator: requiredValidator,
      hintText: 'Введите номер телефона:',
      typeForm: 'phone',
      onReady: onReady,
      keyboardType: TextInputType.phone,
      needRequest: needRequest,
    );
  }

  /// Input для ввода пароля с соответствующими настройками
  static password(
      {Key? keyForm, String? hintText, TextEditingController? textController}) {
    return CustomInput(
      keyForm: keyForm,
      typeForm: 'password',
      textController: textController,
      hintText: hintText ?? 'Введите пароль:',
    );
  }

  /// Input для ввода даты с соответствующими настройками
  static date(
      {Key? keyForm,
      TextEditingController? textController,
      bool? requiredValidator,
      bool needRangeDate = false,
      Future<String?>? Function(String)? onReady,
      bool? needRequest}) {
    return CustomInput(
      keyForm: keyForm,
      textController: textController,
      keyboardType: TextInputType.number,
      requiredValidator: requiredValidator,
      hintText: !needRangeDate ? 'ДД-ММ-ГГ' : 'ДД.ММ.ГГ — ДД.ММ.ГГ',
      typeForm: !needRangeDate ? 'date' : 'date_range',
      readOnly: true,
      needRequest: needRequest,
      onReady: onReady,
    );
  }

  /// CheckBox для подтверждения с соответствующими настройками
  static checkBox(
      {String? text,
      bool? needStandardValidator,
      bool? value,
      Function? onChanged,
      bool? moderator,
      Future<String?>? Function(bool)? onReady}) {
    return CustomCheckBox(
      text: text,
      onReady: onReady,
      onChanged: onChanged,
      moderator: moderator,
      value: value,
      needStandardValidator: needStandardValidator,
    );
  }
}
