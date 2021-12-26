import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

///   created               : Aditya Pratama
///   originalFilename      : log
///   date                  : 11 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————

String _tag = 'GREDU LOG ->';

class GreduLog extends LogPrinter {
  GreduLog(this.className);

  final String className;

  @override
  List<String> log(LogEvent event) {
    final AnsiColor? color = PrettyPrinter.levelColors[event.level];
    final String? emoji = PrettyPrinter.levelEmojis[event.level];
    return <String>[
      color!('$emoji [$className] ${event.message}'),
    ];
  }
}

final Logger _log = Logger(
  filter: ProductionFilter(),
  printer: GreduLog(_tag),
);

void log(String message) {
  debugPrint(message);
}

void print(String message) {
  debugPrint(message, wrapWidth: 5000);
}

void logD(String message) {
  debugPrint(message, wrapWidth: 5000);
}

void logE(String message) {
  if (kDebugMode) {
    _log.e(message);
  }
}

void logI(String message) {
  debugPrint(message, wrapWidth: 5000);
}

void logW(String message) {
  if (kDebugMode) {
    _log.w(message);
  }
}

String rupiahFormat(double d) {
  try {
    final NumberFormat currencyFormatter = NumberFormat.currency(locale: 'ID');
    return currencyFormatter.format(d).replaceAll('IDR', 'Rp. ').replaceAll(',00', '');
  } catch (e) {
    return 'Rp. 0';
  }
}

// —————————————————————————————————————————————————————————————————————————
// EXTENSION FUNCTION  —————————————————————————————————————————————————————
// —————————————————————————————————————————————————————————————————————————
extension LogStringExtension on String {
  void logX() => log(this);

  void logIX() => logI(this);

  void logEX() => logE(this);

  void logWX() => logW(this);
}
