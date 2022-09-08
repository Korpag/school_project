import 'package:school_project/widgets/avatar.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Можно ли задать высоту Аватара', (WidgetTester tester) async {
    // Arrange
    const double value = 65;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Avatar(height: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == value);

    // Assert
    expect(finder, findsOneWidget);
  });
}
