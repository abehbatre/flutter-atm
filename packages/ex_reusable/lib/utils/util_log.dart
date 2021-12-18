import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

///   created               : Aditya Pratama
///   originalFilename      : log
///   date                  : 11 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————

var _tag = "GREDU LOG ->";

class GreduLog extends LogPrinter {
  final String className;

  GreduLog(this.className);

  @override
  List<String> log(LogEvent event) {
    AnsiColor? color = PrettyPrinter.levelColors[event.level];
    String? emoji = PrettyPrinter.levelEmojis[event.level];
    return [color!('$emoji [$className] ${event.message}')];
  }
}

final _log = Logger(
  filter: ProductionFilter(),
  // output: ConsoleOutput(),
  printer: GreduLog(_tag),
);

log<T>(message) {
  // if (kDebugMode) _log.d("$message");
  debugPrint(message);
}

print<T>(message) {
  // if (kDebugMode) _log.d("$message");
  debugPrint(message, wrapWidth: 5000);
}

logD<T>(message) {
  // if (kDebugMode) _log.d("$message");
  debugPrint(message, wrapWidth: 5000);
}

logE<T>(message) {
  if (kDebugMode) _log.e("$message");
  // debugPrint(message, wrapWidth: 5000);
}

logI<T>(message) {
  // if (kDebugMode) _log.i(message);
  debugPrint(message, wrapWidth: 5000);
}

logW<T>(message) {
  if (kDebugMode) _log.w("$message");
  // debugPrint(message, wrapWidth: 5000);
}

String rupiahFormat(double d) {
  try {
    final currencyFormatter = NumberFormat.currency(locale: 'ID');
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
