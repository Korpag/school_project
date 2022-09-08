import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/widgets/description.dart' as description;
import '../widget_test.dart';

void main() {

  testWidgets('Отображается ли заголовок в виджете',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'Заголовок';

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(title: value)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Отображается ли описание в виджете',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'Описание';

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(description: value)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Работает ли настраиваемый отступ', (WidgetTester tester) async {
    // Arrange
    const double value = 20;
    const String title = 'Заголовок';
    const String desc = 'Описание';

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(
            description: desc, title: title, distanceBetweenItems: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли настроить FontSize заголовка',
      (WidgetTester tester) async {
    // Arrange
    const String title = 'Заголовок';
    const double value = 30;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(title: title, fontSizeTitle: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.fontSize == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли настроить FontSize описания',
      (WidgetTester tester) async {
    // Arrange
    const String desc = 'Описание';
    const double value = 16;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(
            description: desc, fontSizeDescription: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.fontSize == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли настроить цвет текста описания',
      (WidgetTester tester) async {
    // Arrange
    const String desc = 'Описание';
    const Color value = Colors.orange;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(
            description: desc, colorDescription: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.color == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли настроить FontWeight описания',
      (WidgetTester tester) async {
    // Arrange
    const String desc = 'Описание';
    const FontWeight value = FontWeight.w700;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(
      description: desc,
      fontWeightDescription: value,
    )));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.fontWeight == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли настроить цвет текста заголовка',
      (WidgetTester tester) async {
    // Arrange
    const String title = 'Заголовок';
    const Color value = Colors.orange;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(title: title, colorTitle: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.color == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли настроить FontWeight описания',
      (WidgetTester tester) async {
    // Arrange
    const String title = 'Заголовок';
    const FontWeight value = FontWeight.w100;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(
      title: title,
      fontWeightTitle: value,
    )));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.fontWeight == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно задать црасположение текста по центру',
      (WidgetTester tester) async {
    // Arrange
    const String title = 'Заголовок';
    const bool value = true;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(
      title: title,
      textAlignCenter: value,
    )));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.textAlign == TextAlign.center);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли задать максимальное кол-во строк в описании',
      (WidgetTester tester) async {
    // Arrange
    const String desc = 'Описание';
    const int value = 6;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(
      description: desc,
      maxLinesDescription: value,
    )));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.maxLines == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли задать максимальное кол-во строк в заголовке',
      (WidgetTester tester) async {
    // Arrange
    const String title = 'Заголовок';
    const int value = 6;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: description.Description(title: title, maxLinesTitle: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.maxLines == value);

    // Assert
    expect(finder, findsOneWidget);
  });
}
