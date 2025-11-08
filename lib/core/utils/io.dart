class IO {
  static bool isDebugger = true;


  static void printFullText(String text) {
    if (!isDebugger) return;
    final pattern = RegExp('.{1,800}');
    // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => printOk(match.group(0)!));
  }

  static void printWarning(String text) {
    if (!isDebugger) return;
    if (text.isEmpty) return;
    print('\x1B[33m$text\x1B[0m');
  }

  static void printError(String text) {
    if (!isDebugger) return;
    if (text.isEmpty) return;
    print('\x1B[31m$text\x1B[0m');
  }

  static void printOk(String text) {
    if (!isDebugger) return;
    if (text.isEmpty) return;
    print('\x1B[32m$text\x1B[0m');
  }

  static void printBlue(String text) {
    if (!isDebugger) return;
    if (text.isEmpty) return;
    print('\x1B[34m$text\x1B[0m');
  }
}
