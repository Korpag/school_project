import 'package:school_project/theme/app_icons.dart';
import 'package:school_project/widgets/coin.dart';
import '../widget_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {

  testWidgets('Принимает ли виджет свои иконки', (WidgetTester tester) async {
    // Arrange
    Image value = CustomIcons.rub;

    // Act
    await tester.pumpWidget(RequiredMaterialApp(widget: Coin(icon: value)));
    final finder = find.widgetWithImage(
        Coin, const AssetImage('lib/assets/images/icons/rub.png'));

    // Assert
    expect(finder, findsOneWidget);
  });


  testWidgets('Можно ли передать свой размер иконки',
      (WidgetTester tester) async {
    // Arrange
    const double value = 98;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Coin(iconSize: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Отображается ли количество монет/стикеров',
      (WidgetTester tester) async {
    // Arrange
    const String value = '100';
    const bool plus = false;
    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: Coin(count: value, plus: plus)));
    final finder = find.text(value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли добавить знак плюса к count',
      (WidgetTester tester) async {
    // Arrange
    const String value = '100';
    const bool plus = true;
    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: Coin(count: value, plus: plus)));
    final finder = find.text('+100');

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Есть ли пробел между тысячными, если count свыше 999',
      (WidgetTester tester) async {
    // Arrange
    const String value = '5488996';
    const bool plus = false;
    // Act
    await tester.pumpWidget(
        const RequiredMaterialApp(widget: Coin(count: value, plus: plus)));
    final finder = find.text('5 488 996');

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли передать цвет текста', (WidgetTester tester) async {
    // Arrange
    const Color value = Colors.orange;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Coin(color: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.color == value);

    // Assert
    expect(finder, findsOneWidget);
  });

  testWidgets('Можно ли передать fontSize текста', (WidgetTester tester) async {
    // Arrange
    const double value = 33;

    // Act
    await tester
        .pumpWidget(const RequiredMaterialApp(widget: Coin(fontSize: value)));
    final finder = find.byWidgetPredicate(
        (widget) => widget is Text && widget.style!.fontSize == value);

    // Assert
    expect(finder, findsOneWidget);
  });


  testWidgets('Можно ли передать задать отступ между иконкой и count',
      (WidgetTester tester) async {
    // Arrange
    const double value = 25;

    // Act
    await tester.pumpWidget(const RequiredMaterialApp(
        widget: Coin(
      offset: value,
    )));
    final finder = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == value);

    // Assert
    expect(finder, findsOneWidget);
  });
}
