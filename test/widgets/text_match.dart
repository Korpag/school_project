import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/widgets/text_match.dart';

void main() {

  testWidgets('Выделяет ли искомый текст среди контента',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'мат';
    const String content = 'Шахматный клуб';

    // Act
    await tester.pumpWidget(const Directionality(
      textDirection: TextDirection.ltr,
      child: TextMatch(content: content, searchString: value),
    ));
    final finder = find.textContaining(value, findRichText: true);

    // Assert
    expect(finder, findsOneWidget);
  });
}
