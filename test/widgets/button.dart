import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/button.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  testWidgets('Можно ли изменить высоту кнопки', (WidgetTester tester) async {
    // Arrange
    const double value = 133;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Button(height: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли настроить горизонтальный паддинг',
      (WidgetTester tester) async {
    // Arrange
    const double value = 133;
    const String text = 'кнопка';

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Button(
      text: text,
      horizontalPadding: value,
    )));
    final finder = find.byWidgetPredicate((widget) =>
        widget is Container &&
        widget.padding == const EdgeInsets.symmetric(horizontal: value));

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Отображается ли передаваемый текст',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'Кнопка';

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Button(text: value)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Настраивается ли цвет текста кнопки',
      (WidgetTester tester) async {
    // Arrange
    const String text = 'Кнопка';
    const Color value = Colors.brown;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Button(text: text, colorText: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.color == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Настраивается ли размер текста кнопки',
      (WidgetTester tester) async {
    // Arrange
    const String text = 'Кнопка';
    const double value = 5;

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: Button(text: text, fontSize: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.fontSize == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Настраивается ли толщина текста кнопки',
      (WidgetTester tester) async {
    // Arrange
    const String text = 'Кнопка';
    const FontWeight value = FontWeight.w100;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Button(text: text, fontWeight: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.fontWeight == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Работает ли подчеркивание текста', (WidgetTester tester) async {
    // Arrange
    const String text = 'Кнопка';
    const bool value = true;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Button(text: text, textDirection: value)));
    final finder = find.byWidgetPredicate((widget) =>
        widget is Text && widget.style!.decoration == TextDecoration.underline);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Передается ли своя иконка', (WidgetTester tester) async {
    // Arrange
    const IconData value = Icons.ac_unit;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Button(icon: value)));
    final finder = find.byIcon(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Передается ли цвет иконки', (WidgetTester tester) async {
    // Arrange
    const Color value = Colors.brown;

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: Button(iconColor: value)));
    final finder = find
        .byWidgetPredicate((widget) => widget is Icon && widget.color == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Отображается ли цвет серым, если кнопка недоступна',
      (WidgetTester tester) async {
    // Arrange
    const String text = 'Кнопка';
    const bool value = false;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Button(text: text, permission: value)));
    final finder = find.byWidgetPredicate((widget) =>
        widget is Text && widget.style!.color == AppColor.disabledText);

    // Assert
    expect(finder, findsOneWidget);
  });
}
