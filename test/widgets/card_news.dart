import 'package:school_project/widgets/card_news.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('Можно ли передать описание', (WidgetTester tester) async {
    // Arrange
    const String value = 'Описание';

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: NewsCard(description: value)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });
}
