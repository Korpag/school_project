import 'package:school_project/widgets/card_project.dart';
import 'package:school_project/widgets/time_counter.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('Можно ли передать заголовок лейблу',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'Математика';

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: ProjectCard(titleLabel: value)));
    final finder = find.text(value.toUpperCase());

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли передать описание', (WidgetTester tester) async {
    // Arrange
    const String value = 'Краткое описание';

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: ProjectCard(description: value)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли передать дату', (WidgetTester tester) async {
    // Arrange
    final value = DateTime.now();

    // Act
    await tester.pumpWidget(
        RequiredMaterialApp(widget: ProjectCard(date: value.toString())));
    final finder = find.text(TimeCounter.textLastDay());

    // Assert
    expect(finder, findsOneWidget);
  });
}
