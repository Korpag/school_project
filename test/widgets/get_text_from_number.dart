import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/widgets/get_text_from_number.dart';

void main() {
  const String one = 'дом';
  const String two = 'дома';
  const String five = 'домов';
  test(
      'Проверка правильности отображения окончания для чисел заканчивающихся на 1',
      () {
    // Arrange
    const int value = 191;

    // Act
    final result = getTextFromNumber(
        number: value.toString(), one: one, two: two, five: five);

    // Assert
    expect(result, 'дом');
  });

  test(
      'Проверка правильности отображения окончаний для чисел заканчивающихся на 2-4',
      () {
    // Arrange
    const int value = 24;

    // Act
    final result = getTextFromNumber(
        number: value.toString(), one: one, two: two, five: five);

    // Assert
    expect(result, 'дома');
  });

  test(
      'Проверка правильности отображения окончаний для чисел заканчивающихся на 0, 5-9',
      () {
    // Arrange
    const int value = 848;

    // Act
    final result = getTextFromNumber(
        number: value.toString(), one: one, two: two, five: five);

    // Assert
    expect(result, 'домов');
  });

  test(
      'Проверка правильности отображения окончаний для чисел-исключений заканчивающихся на 11-14',
      () {
    // Arrange
    const int value = 82211;

    // Act
    final result = getTextFromNumber(
        number: value.toString(), one: one, two: two, five: five);

    // Assert
    expect(result, 'домов');
  });
}
