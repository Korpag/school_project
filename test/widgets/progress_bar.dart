import 'package:school_project/widgets/progress_bar.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets(
      'Есть ли подсчет выполненных заданий при включенном модераторстве',
      (WidgetTester tester) async {
    // Arrange
    const int count = 20;
    const int countDone = 2;
    const bool value = true;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget:
            ProgressBar(count: count, countDone: countDone, moderator: value)));
    final finder = find.text('Заданий проверено 2 из 20');

    // Assert
    expect(finder, findsOneWidget);
  });
}
