import 'package:school_project/widgets/custom_input.dart';

import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Можно ли сделать инпут только для чтения',
      (WidgetTester tester) async {
    // Arrange
    const bool value = true;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Material(child: CustomInput(readOnly: value))));
    final finder = find.byWidgetPredicate(
        (widget) => widget is TextField && widget.readOnly == true);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли задать AutoValidateMode', (WidgetTester tester) async {
    // Arrange
    const AutovalidateMode value = AutovalidateMode.always;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Material(child: CustomInput(autoValidateMode: value))));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Form && widget.autovalidateMode == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли задать тип клавиатуру', (WidgetTester tester) async {
    // Arrange
    const TextInputType value = TextInputType.number;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Material(child: CustomInput(keyboardType: value))));
    final finder = find.byWidgetPredicate(
        (widget) => widget is TextField && widget.keyboardType == value);

    // Assert
    expect(finder, findsOneWidget);
  });


  testWidgets('Можно ли передать свой контроллер', (WidgetTester tester) async {
    // Arrange
    const String value = 'текст';

    // Act
    await tester.pumpWidget(RequiredMaterialApp(
        widget: Material(child: CustomInput(textController: TextEditingController()..text = value))));
    final finder = find.byWidgetPredicate(
            (widget) => widget is TextField && widget.controller!.text == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли задать свой hint', (WidgetTester tester) async {
    // Arrange
    const String value = 'подсказка';

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Material(child: CustomInput(hintText: value))));
    final finder = find.byWidgetPredicate(
            (widget) => widget is TextField && widget.decoration!.labelText == value);

    // Assert
    expect(finder, findsOneWidget);
  });
}
