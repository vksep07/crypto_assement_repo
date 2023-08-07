import 'dart:developer';

class AppLogger {
  static bool logEnable = false;

  static void printLog(
    Object object, {
    String? tag,
  }) {
    if (logEnable) {
      log('[ ${tag ?? 'log'} ] ${object.toString()}');
    }
  }
}
