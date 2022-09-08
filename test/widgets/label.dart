import 'package:school_project/widgets/label.dart';

import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Можно ли задать высоту лейбла', (WidgetTester tester) async {
    // Arrange
    const double value = 50;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Label(height: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Передается ли тайтл лейбла', (WidgetTester tester) async {
    // Arrange
    const String value = 'Математика';

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Label(title: value)));
    final finder = find.text(value.toUpperCase());

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Передается ли цвет текста лейбла', (WidgetTester tester) async {
    // Arrange
    const String text = 'Математика';
    const Color value = Colors.orange;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Label(title: text, colorText: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.color == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Передается ли толщина текста лейбла',
      (WidgetTester tester) async {
    // Arrange
    const String text = 'Математика';
    const FontWeight value = FontWeight.w100;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Label(title: text, fontWeight: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.fontWeight == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Задается ли горизонтальный паддинг для лейбла',
      (WidgetTester tester) async {
    // Arrange
    const double value = 25;

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: Label(horizontalPadding: value)));
    final finder = find.byWidgetPredicate((widget) =>
        widget is Padding &&
        widget.padding == const EdgeInsets.symmetric(horizontal: value));

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли задать цвет плашки лейбла',
      (WidgetTester tester) async {
    // Arrange
    const Color value = Colors.orange;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Material(child: Label(color: value))));
    final finder =
        ((tester.firstWidget(find.byType(DecoratedBox)) as DecoratedBox)
                .decoration as BoxDecoration)
            .color;

    // Assert
    expect(finder, value);
  });
}
