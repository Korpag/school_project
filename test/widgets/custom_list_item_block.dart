import 'package:school_project/widgets/custom_list_item_block.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Можно ли передать заголовок', (WidgetTester tester) async {
    // Arrange
    const String value = 'Заголовок';

    // Act
    await tester.pumpWidget(RequiredMaterialApp(
        widget: CustomListBlock(
            title: value,
            countList: 5,
            itemBuilder: (BuildContext context, int index) {
              return const SizedBox();
            })));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли задать цвет заголовока', (WidgetTester tester) async {
    // Arrange
    const String title = 'Заголовок';
    const Color value = Colors.brown;

    // Act
    await tester.pumpWidget(RequiredMaterialApp(
        widget: CustomListBlock(
            title: title,
            countList: 5,
            titleColor: value,
            itemBuilder: (BuildContext context, int index) {
              return const SizedBox();
            })));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.color == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли задать высоту итема', (WidgetTester tester) async {
    // Arrange
    const double value = 30;

    // Act
    await tester.pumpWidget(RequiredMaterialApp(
        widget: CustomListBlock(
            countList: 5,
            height: value,
            itemBuilder: (BuildContext context, int index) {
              return const SizedBox();
            })));
    final finder = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == value);

    // Assert
    expect(finder, findsOneWidget);
  });


  testWidgets(
      'Можно ли сделать пролистывание без фиксирования на каждой странице',
      (WidgetTester tester) async {
    // Arrange
    const bool value = false;

    // Act
    await tester.pumpWidget(RequiredMaterialApp(
        widget: CustomListBlock(
            countList: 5,
            pageSnapping: value,
            itemBuilder: (BuildContext context, int index) {
              return const SizedBox();
            })));
    final finder = find.byWidgetPredicate(
        (widget) => widget is PageView && widget.pageSnapping == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets(
      'Можно ли настроить процент занимания страницы на экране от 0 до 1',
      (WidgetTester tester) async {
    // Arrange
    const double value = 0.5;

    // Act
    await tester.pumpWidget(RequiredMaterialApp(
        widget: CustomListBlock(
            countList: 5,
            viewportFraction: value,
            itemBuilder: (BuildContext context, int index) {
              return const SizedBox();
            })));
    final finder = find.byWidgetPredicate((widget) =>
        widget is PageView && widget.controller.viewportFraction == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('При выборе типа "vertical", меняется ли отображение',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'vertical';

    // Act
    await tester.pumpWidget(RequiredMaterialApp(
        widget: CustomListBlock(
            countList: 5,
            type: value,
            itemBuilder: (BuildContext context, int index) {
              return const SizedBox();
            })));
    final finder = find.byType(ListView);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли задать высоту под вертикальный тип виджета',
      (WidgetTester tester) async {
    // Arrange
    const double value = 555;

    // Act
    await tester.pumpWidget(RequiredMaterialApp(
        widget: CustomListBlock(
            countList: 5,
            type: 'vertical',
            heightVerticalList: value,
            itemBuilder: (BuildContext context, int index) {
              return const SizedBox();
            })));
    final finder = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == value);

    // Assert
    expect(finder, findsOneWidget);
  });
}
