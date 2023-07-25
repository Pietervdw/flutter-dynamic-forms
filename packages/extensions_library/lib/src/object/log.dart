import 'package:logger/logger.dart';

enum LogType { verbose, debug, info, warning, error, wtf }

extension Log on Object {
  void log({
    String? message,
    LogType logType = LogType.info,
    bool logMethods = true,
    bool printTime = false,
  }) {
    //if  (kDebugMode) {
    var logger = Logger(
      filter: LogLiveAndDebugFilter(),
      printer: PrettyPrinter(
          methodCount: logMethods ? 2 : 0,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: false,
          printTime: printTime),
    );

    var logMessage = toString();
    if (message != null) {
      var emoji = "💡";
      logMessage =
          "$emoji $message \n--------------------------------------------------- \n${toString()}";
    }

    switch (logType) {
      case LogType.debug:
        logger.d(logMessage);
        break;
      case LogType.verbose:
        logger.v(logMessage);
        break;
      case LogType.info:
        logger.i(logMessage);
        break;
      case LogType.warning:
        logger.w(logMessage);
        break;
      case LogType.error:
        logger.e(logMessage);
        break;
      case LogType.wtf:
        logger.wtf(logMessage);
        break;
    }
  }
//}
}


class LogLiveAndDebugFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}