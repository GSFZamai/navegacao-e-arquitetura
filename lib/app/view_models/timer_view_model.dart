import 'dart:async';

import 'package:flutter/widgets.dart';

class TimerViewModel extends ChangeNotifier {
  bool isRunning = false;
  Timer? timer;
  Duration currentTime = Duration.zero;

  void startTimer(int initialMinutes, ValueNotifier<bool> isPaused) {
    currentTime = Duration.zero;
    isRunning = true;
    notifyListeners();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (isPaused.value) return;
      if (currentTime.inSeconds < initialMinutes) {
        currentTime += Duration(seconds: 1);
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    isRunning = false;
    notifyListeners();
    timer?.cancel();
  }
}
