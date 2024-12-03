import 'dart:convert' show JsonEncoder;
import 'package:logger/logger.dart';

class CustomLogger {
  static final Map<String, Logger> _loggers = {};

  static Logger getLogger(String className) {
    return _loggers.putIfAbsent(
        className, () => Logger(printer: Printer(className)));
  }
}

/// [Printer] - Custom log printer to display the data with different levels.
/// Use it whenever you log something in console.
/// This [Printer] overrides the default LogPrinter with customized logs.
/// Includes verbose, debug, info, warning, error, wtf level of logs(Use in the necessary places).
/// Use like:
/// ```dart
///   var log = CustomLogger.getLogger('Dashboard');
///   log.i('test');
///   log.v('test');
///   log.d('test');
///   log.e('test');
/// ```
class Printer extends LogPrinter {
  /// default levels of logs includes verbose, debug, info, warning, error, wtf.
  static final levelPrefixes = {
    Level.debug: '[D]',
    Level.info: '[I]',
    Level.warning: '[W]',
    Level.error: '[E]',
  };

  /// default colors for different levels of logs.
  /// [INFO]: Colors will not be applied in some of the terminal.
  static final levelColors = {
    Level.debug: const AnsiColor.none(),
    Level.info: const AnsiColor.fg(12),
    Level.warning: const AnsiColor.fg(208),
    Level.error: const AnsiColor.fg(196),
  };

  final String className;

  Printer(this.className);

  @override
  List<String> log(LogEvent event) {
    var messageStr = _stringifyMessage(event.message);
    var errorStr = event.error != null ? '  ERROR: ${event.error}' : '';
    return ['${_makeColor(event.level)} $messageStr$errorStr'];
  }

  /// Creates color for the messages in the logs.
  String _makeColor(Level level) {
    var prefix = levelPrefixes[level];
    var color = levelColors[level];
    return color!('$prefix | $className');
  }

  /// Extracts the messages for the logs.
  String _stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      var encoder = const JsonEncoder.withIndent(null);
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
