import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/widgets/time_counter.dart';
import 'package:intl/intl.dart';
import '../widget_test.dart';

void main() {
  final currentDay = DateTime.now();
  DateTime dateTime({required int day}) {
    return DateTime(currentDay.year, currentDay.month, day);
  }

  String dateFormat({required DateTime value}) {
    return DateFormat('dd.MM', 'Ru_ru')
        .format(DateTime.parse(value.toString()));
  }

  testWidgets('Проверка отображаемого текста при истекших сроках',
      (WidgetTester tester) async {
    // Arrange
    final DateTime value = dateTime(day: currentDay.day - 1);

    // Act
    await tester.pumpWidget(
        RequiredMaterialApp(widget: TimeCounter(date: value.toString())));
    final finder = find.text(TimeCounter.textFinish());

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Проверка отображаемого текста при сроках меньше одного дня',
      (WidgetTester tester) async {
    // Arrange
    final DateTime value = dateTime(day: currentDay.day);

    // Act
    await tester.pumpWidget(
        RequiredMaterialApp(widget: TimeCounter(date: value.toString())));
    final finder = find.text(TimeCounter.textLastDay());

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Проверка отображаемого текста при сроках меньше недели',
      (WidgetTester tester) async {
    // Arrange
    final DateTime value = dateTime(day: currentDay.day + 4);

    // Act
    await tester.pumpWidget(
        RequiredMaterialApp(widget: TimeCounter(date: value.toString())));
    final finder = find.text(TimeCounter.textLessWeek(
        countDay: value.difference(currentDay).inDays));

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Проверка отображаемого текста при сроках ровно неделя',
      (WidgetTester tester) async {
    // Arrange
    final DateTime value = dateTime(day: currentDay.day + 8);

    // Act
    await tester.pumpWidget(
        RequiredMaterialApp(widget: TimeCounter(date: value.toString())));
    final finder = find.text(TimeCounter.textWeek());

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets(
      'Проверка отображаемого текста при сроках больше недели, но меньше двух',
      (WidgetTester tester) async {
    // Arrange
    final DateTime value = dateTime(day: currentDay.day + 10);

    // Act
    await tester.pumpWidget(
        RequiredMaterialApp(widget: TimeCounter(date: value.toString())));
    final finder = find.text(
        TimeCounter.textMoreThanAWeek(dateFormat: dateFormat(value: value)));

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Проверка отображаемого текста при сроках больше двух недель',
      (WidgetTester tester) async {
    // Arrange
    final DateTime value = dateTime(day: currentDay.day + 50);

    // Act
    await tester.pumpWidget(
        RequiredMaterialApp(widget: TimeCounter(date: value.toString())));
    final finder = find.text(TimeCounter.textAway(
        dateFormat: dateFormat(value: value), dateEvent: value));

    // Assert
    expect(finder, findsOneWidget);
  });
}
