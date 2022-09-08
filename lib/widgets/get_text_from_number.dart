/// Специальная функция-обработчик окончаний. Возвращает нужное вам слово в зависимости от числа
String getTextFromNumber(
    {

    /// Число
    required String number,

    /// Текст для цифры один
    String? one,

    /// Текст для цифры два
    String? two,

    /// Текст для цифры пять
    String? five}) {
  int _numberLength = number.length;

  /// Отсекаем лишнее, если длинна строки больше 2
  int _number = _numberLength > 2
      ? int.parse(number.substring(_numberLength - 2))
      : int.parse(number);

  /// Обрабатываем исключения
  if (_number > 10 && _number < 15) {
    return five ?? '';
  } else {
    /// После исключений обрабатываем числа до 10
    int _numberLast = _number.toString().length > 1
        ? int.parse(_number.toString().substring(1))
        : _number;
    if (_numberLast == 0) {
      return five ?? '';
    }
    if (_numberLast == 1) {
      return one ?? '';
    }
    if (_numberLast > 4) {
      return five ?? '';
    }
    if (_numberLast > 1) {
      return two ?? '';
    }
  }
  return '';
}
