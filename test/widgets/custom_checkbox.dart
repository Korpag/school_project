import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/custom_checkbox.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Передается ли сопроводительный текст чекбоксу',
      (WidgetTester tester) async {
    // Arrange
    const String value = 'Этот чекбокс тут не просто так';

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Material(child: CustomCheckBox(text: value))));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли чекбоксу передать значение true/false',
      (WidgetTester tester) async {
    // Arrange
    const bool value = true;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Material(child: CustomCheckBox(value: value))));
    final finder = find.byWidgetPredicate(
        (widget) => widget is FormField && widget.initialValue == value);

    // Assert
    expect(finder, findsOneWidget);
  });


  testWidgets('Меняется ли отображения при включенном модераторстве',
      (WidgetTester tester) async {
    // Arrange
    const Color value = AppColor.disabledText;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Material(child: CustomCheckBox(moderator: true))));
    final finder = ((tester.firstWidget(find.byType(Container)) as Container)
            .decoration as BoxDecoration)
        .color;

    // Assert
    expect(finder, value);
  });
}
