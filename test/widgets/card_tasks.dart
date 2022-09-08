import 'package:flutter/material.dart';
import 'package:school_project/widgets/card_tasks.dart';
import 'package:school_project/widgets/time_counter.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('Можно ли передать свою иконку', (WidgetTester tester) async {
    // Arrange
    const IconData value = Icons.ac_unit;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: TasksCard(icon: value)));
    final finder = find.byIcon(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли передать заголовок лейбла',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'Математика';

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: TasksCard(titleLabel: value)));
    final finder = find.text(value.toUpperCase());

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли передать дату', (WidgetTester tester) async {
    // Arrange
    final value = DateTime.now();

    // Act
    await tester.pumpWidget(
        RequiredMaterialApp(widget: TasksCard(date: value.toString())));
    final finder = find.text(TimeCounter.textLastDay());

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли передать заголовок описание',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'Краткое описание';

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: TasksCard(description: value)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли передать стоимость задания',
      (WidgetTester tester) async {
    // Arrange
    const String value = '516';

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: TasksCard(count: value)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Передается ли цвет плашки под иконку',
          (WidgetTester tester) async {
        // Arrange
        const Color value = Colors.deepOrange;

        // Act
        await tester.pumpWidget(const RequiredMaterialApp(
            widget: Material(child: TasksCard(color: value))));
        final finder = ((tester.widget(find.byType(Container).at(1)) as Container)
            .decoration as BoxDecoration)
            .color;

        // Assert
        expect(finder, value);
      });

}
