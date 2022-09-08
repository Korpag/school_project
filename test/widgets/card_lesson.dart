import 'package:school_project/widgets/card_lesson.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Можно ли передать title', (WidgetTester tester) async {
    // Arrange
    const String value = 'Заголовок';

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: LessonCard(title: value)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Корректно ли отображается дата', (WidgetTester tester) async {
    // Arrange
    const String value = '2018-08-03T00:00:00.000Z';

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: LessonCard(date: value)));
    final finder = find.text('3 августа');

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли передавать цвет карточке',
      (WidgetTester tester) async {
    // Arrange
    const Color value = Colors.purple;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Material(child: LessonCard(colorCard: value))));
    final finder = ((tester.firstWidget(find.byType(Container)) as Container)
            .decoration as BoxDecoration)
        .color;

    // Assert
    expect(finder, value.withOpacity(0.1));
  });
}
