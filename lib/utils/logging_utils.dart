import 'dart:developer';

class LoggingUtils {
  static void logStartFunction(String functionName) {
    var current = DateTime.now();
    log("[TimeStamp : ${current.hour}.${current.minute}.${current.second}] ON START FUNCTION $functionName");
  }

  static void logEndFunction(String functionName) {
    var current = DateTime.now();
    log("[TimeStamp : ${current.hour}.${current.minute}.${current.second}] ON END FUNCTION $functionName");
  }

  static void logDebugFunction(String data, String activity) {
    var current = DateTime.now();
    log("[TimeStamp : ${current.hour}.${current.minute}.${current.second}] [ACTIVITY $activity] [DATA : ${data.toString()}]");
  }

  static void logError(String errMessage, String activity) {
    var current = DateTime.now();
    log("[TimeStamp : ${current.hour}.${current.minute}.${current.second}] [ERROR MESSAGE ON $activity : $errMessage]");
  }
}
