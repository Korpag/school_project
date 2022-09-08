import 'package:flutter/material.dart';
import 'package:school_project/widgets/button.dart';
import 'package:school_project/widgets/description.dart';
import 'package:school_project/widgets/main_layout.dart';
import 'package:school_project/widgets/custom_form.dart';

/// Страница для демонстрации Форм и их тестирования
class TestFormPage extends StatelessWidget {
  const TestFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      horizontalPadding: 12,
        verticalPadding: 12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Description(
                description:
                'Для проверки сетевого запроса, используйте test@mail.ru'),
            CustomForm.email(onReady: (value) async {
              await Future.delayed(const Duration(seconds: 1));
              return value == 'test@mail.ru' ? 'Пользователь существует' : null;
            }),
            CustomForm.text(),
            CustomForm.text(
                hintText: 'Введите текст: (есть autocomplete)',
                autoCompleteList: [
                  'Шах и Мат',
                  'Математика',
                  'Математическая задача',
                  'Биология выматывает?',
                  'Грамматика 2й класс'
                ]),
            CustomForm.password(),
            CustomForm.phone(),
            CustomForm.date(),
            CustomForm.date(needRangeDate: true),
            const SizedBox(height: 25),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) => CustomForm.checkBox())),
            const SizedBox(height: 25),
            CustomForm.checkBox(
                text: 'Обязательный CheckBox', needStandardValidator: true),
            const SizedBox(height: 25),
            CustomForm.checkBox(
                text: 'CheckBox с сетевым запросом',
                needStandardValidator: true,
                onReady: (value) async {
                  await Future.delayed(const Duration(seconds: 1));
                  return value == false ? 'Упс, что-то пошло не так' : null;
                }),
            const SizedBox(height: 25),
            CustomForm.checkBox(
                text: 'CheckBox с сетевым запросом (неуспешным)',
                needStandardValidator: true,
                onReady: (value) async {
                  await Future.delayed(const Duration(seconds: 1));
                  return value == true ? 'Упс, что-то пошло не так' : null;
                }),
            const SizedBox(height: 25),
            Center(child: Button.large(text: 'НАЗАД', borderRadius: 30, onTap: () {Navigator.pop(context);})),
          ],
        ));
  }
}
