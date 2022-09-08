import 'package:school_project/widgets/custom_appbar.dart';
import 'package:school_project/widgets/main_layout.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Передается ли свой виджет', (WidgetTester tester) async {
    // Arrange
    const double height = 33;
    const Widget value = SizedBox(height: height);

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: MainLayout(child: value)));
    final finder = find.byWidgetPredicate(
            (widget) => widget is SizedBox && widget.height == height);

    // Assert
    expect(finder, findsOneWidget);
  });


  testWidgets('Можно ли передать свой кастомный AppBar', (WidgetTester tester) async {
    // Arrange
    final SliverPersistentHeaderDelegate value = CustomAppBar.news(topPaddingDevice: 0);

    // Act
    await tester
        .pumpWidget(RequiredMaterialApp(widget: MainLayout(appBar: value, child: const SizedBox())));
    final finder = find.byType(SliverPersistentHeader);

    // Assert
    expect(finder, findsOneWidget);
  });
}
