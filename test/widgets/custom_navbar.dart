import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/custom_navbar.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Выбранный итем имеет отличный цвет от невыбранного', (WidgetTester tester) async {
    // Arrange
    const Color value = AppColor.htmlText;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: CustomNavBar()));
    final finder = (tester.firstWidget(find.byType(Image)) as Image).color;

    // Assert
    expect(finder, value);
  });
}
