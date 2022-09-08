import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:school_project/widgets/custom_gridview.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Можно ли задать вертикальный отступ',
      (WidgetTester tester) async {
    // Arrange
    const double value = 65;

    // Act
    await tester.pumpWidget(RequiredMaterialApp(
        widget: CustomGridView(
            verticalMargin: value,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return const SizedBox();
            })));
    final finder = find.byWidgetPredicate((widget) =>
        widget is MasonryGridView && widget.mainAxisSpacing == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли задать горизонтальный отступ',
      (WidgetTester tester) async {
    // Arrange
    const double value = 33;

    // Act
    await tester.pumpWidget(RequiredMaterialApp(
        widget: CustomGridView(
            horizontalMargin: value,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return const SizedBox();
            })));
    final finder = find.byWidgetPredicate((widget) =>
        widget is MasonryGridView && widget.crossAxisSpacing == value);

    // Assert
    expect(finder, findsOneWidget);
  });
}
