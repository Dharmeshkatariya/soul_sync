import 'dart:async';

class TimerUtils {
  Timer? _checkTypingTimer;

  void startTypingTimer(Function(String) onTimerEnd, String searchText,
      {int millis = 1000}) {
    _checkTypingTimer?.cancel();
    _checkTypingTimer=null;
    _checkTypingTimer = Timer(Duration(milliseconds: millis), () {
      onTimerEnd(searchText);
    });
  }

  void startTimer(Function() onTimerEnd) {
    _checkTypingTimer?.cancel();
    _checkTypingTimer = Timer(const Duration(milliseconds: 1000), () {
      onTimerEnd();
      _checkTypingTimer = null;
    });
  }

  void resetTimer() {
    _checkTypingTimer?.cancel();
  }
}
