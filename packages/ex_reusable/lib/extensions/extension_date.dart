import 'package:dartx/dartx.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : extension_date
///   date                  : 22 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///    scope                : dateTime <-> string

extension StringToDateExtension on String {
  /// Convert String to Date
  /// ---
  /// @param : format (optional)
  DateTime toDateEx({
    String format = 'yyyy-MM-ddTHH:mm:ssZ',
  }) {
    initializeDateFormatting('in');
    const String locale = 'in';
    return DateFormat(format, locale).parse(this);
  }
}

extension DateToStringExtension on DateTime {
  /// Date to String
  /// ---
  /// @param : format (optional)
  String toStringEx({
    String format = 'yyyy-MM-ddTHH:mm:ssZ',
  }) {
    initializeDateFormatting('in');
    const String locale = 'in';
    final String output = DateFormat(format, locale).format(this);
    return output;
  }
}

extension StringToDateFormatterExtension on String {
  /// formatPastOrToday
  /// ---
  /// require : String (date)
  /// return : if past  -> dd MMM => 23 Jan
  /// return : if today -> hh:mm  => 18:20
  /// return : if yesterday -> hh:mm  => Kemarin
  String formatPastOrToday({
    String format = 'yyyy-MM-ddTHH:mm:ssZ',
  }) {
    String output;
    final String resDate = toDateEx(format: format).toStringEx(format: 'dd MMM');
    final String today = DateTime.now().toStringEx(format: 'dd MMM');
    final String yesterday = (DateTime.now() - 1.days).toStringEx(format: 'dd MMM');

    if (resDate == today) {
      output = (toDateEx(format: format) + 7.hours).toStringEx(format: 'HH:mm');
    } else if (resDate == yesterday) {
      output = 'Kemarin';
    } else {
      output = resDate;
    }
    return output;
  }

  String formatDate({
    String format = 'yyyy-MM-ddTHH:mm:ssZ',
    String to = 'dd MMM yyyy',
    int addHours = 0
  }) {
    String output;
    try {
      output = (toDateEx(format: format) + addHours.hours).toStringEx(format: to);
    } catch (e) {
      output = 'error';
    }
    return output;
  }
}
