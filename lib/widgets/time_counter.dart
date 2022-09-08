import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/get_text_from_number.dart';

class TimeCounter extends StatelessWidget {
  /// Дата события
  final String date;

  const TimeCounter({Key? key, required this.date}) : super(key: key);

  static textFinish() {
    return 'Сроки истекли';
  }

  static textLastDay() {
    return 'Осталось меньше суток';
  }

  static textLessWeek({required int countDay}) {
    return getTextFromNumber(
        number: countDay.toString(),
        one: 'Остался $countDay день',
        two: 'Осталось $countDay дня',
        five: 'Осталось $countDay дней');
  }

  static textWeek() {
    return 'Спеши, осталась неделя';
  }

  static textMoreThanAWeek({required String dateFormat}) {
    return 'До $dateFormat, но не затягивай!';
  }

  static textAway({required String dateFormat, required DateTime dateEvent}) {
    return 'До $dateFormat ${dateEvent.year != DateTime.now().year ? 'следующего года' : 'текущего года'}';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final _dateNow = DateTime.now();
    final _dateEvent = DateTime.parse(date);
    final _countDay = _dateEvent.difference(_dateNow).inDays;
    final _dateFormat =
        DateFormat('dd.MM', 'Ru_ru').format(DateTime.parse(date));
    String _text() {
      /// Обработка событий для сроков меньше недели
      if (_countDay < 7) {
        /// Последний день
        if (_countDay == 0) {
          return textLastDay();
        }

        /// Сроки просрочены
        if (_countDay < 0) {
          return textFinish();
        }

        /// Осталось меньше недели
        return textLessWeek(countDay: _countDay);
      }

      /// Осталось ровно неделя
      if (_countDay == 7) {
        return textWeek();
      }

      /// Обработка событий для сроков больше недели
      if (_countDay > 7) {
        /// Больше двух недель
        if (_countDay > 14) {
          return textAway(dateFormat: _dateFormat, dateEvent: _dateEvent);
        }

        /// От недели до двух
        return textMoreThanAWeek(dateFormat: _dateFormat);
      }
      return '';
    }

    /// Текстовый виджет и его стиль отображения
    return Text(_text(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: _theme.textTheme.caption!
            .copyWith(fontSize: 12, color: AppColor.disabledText));
  }
}
