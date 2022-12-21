
import 'flavor_config.dart';

class Logger {
  static void write(String text, {bool isError = false}) {
    if (FlavorConfig.instance.values!.environment == "DEV")
      Future.microtask(() => print('** $text. isError: [$isError]'));
  }

  static void writeLog(text) {
    if (FlavorConfig.instance.values!.environment == "DEV")
      Future.microtask(() => print(text));
  }

  static void logLongString(String s) {
    if (FlavorConfig.instance.values!.environment == "DEV") {
      if (s == null || s.length <= 0) return;
      const int n = 1000;
      int startIndex = 0;
      int endIndex = n;
      while (startIndex < s.length) {
        if (endIndex > s.length) endIndex = s.length;
        print(s.substring(startIndex, endIndex));
        startIndex += n;
        endIndex = startIndex + n;
      }
    }
  }
}
