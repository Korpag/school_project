import 'package:school_project/widgets/flash.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Можно ли передать заголовок в виджет',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'Flash';

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Flash(title: value)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли передать описание в виджет',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'Краткое описание';

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: Flash(description: value)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Отображается ли виджет при нажатии кнопки "Закрыть"',
      (WidgetTester tester) async {
    // Arrange
    const bool value = false;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Flash(show: value)));
    final finder = find.byWidgetPredicate((widget) => widget is SizedBox);

    // Assert
    expect(finder, findsOneWidget);
  });
}
