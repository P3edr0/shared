import 'package:intl/intl.dart';
import 'package:shared/utils/formatters/string_formatter.dart';

import '../../locale/locale_controller.dart';
import 'int_formatter.dart';

class SharedDateFormatter {
  String dateResume(DateTime date) {
    final localeController = LocaleController.instance();
    final code = localeController.locale.languageCode;
    final day = IntFormatter.toShow(date.day);
    final weekDay = DateFormat(
      "EEEE",
      code,
    ).format(date).firstLetterUppercase();

    final month = DateFormat("MMMM", code).format(date).firstLetterUppercase();

    return '$weekDay, $day $month';
  }

  static String toDayMonthYear(DateTime date) {
    final day = date.day;
    final month = date.month;
    final year = date.year;

    final handledDay = IntFormatter.toShow(day);

    return '$handledDay/$month/$year';
  }
}

extension Normalize on DateTime {
  DateTime normalize() {
    return DateTime(year, month, day);
  }
}
