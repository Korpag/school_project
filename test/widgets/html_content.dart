import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/widgets/html_content.dart';
import '../widget_test.dart';

void main() {

  testWidgets('Отображается ли текст', (WidgetTester tester) async {
    // Arrange
    const value =
        '''<p><strong>т</strong>ест<em>и</em>ру<span style="text-decoration: underline;">е</span>м</p>''';

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: HtmlContent(data: value)));
    final finder = find.textContaining('тестируем', findRichText: true);

    // Assert
    expect(finder, findsOneWidget);
  });
}
