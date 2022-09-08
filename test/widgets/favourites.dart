import 'package:school_project/widgets/favourites.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Можно ли задать высоту', (WidgetTester tester) async {
    // Arrange
    const double value = 23;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Favourites(size: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли добавить обводку', (WidgetTester tester) async {
    // Arrange
    const bool value = true;

    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: Favourites(border: value)));
    final finder = find.byType(SizedBox);

    // Assert
    expect(finder, findsNWidgets(2));
  });
}
