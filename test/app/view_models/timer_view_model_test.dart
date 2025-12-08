import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/view_models/timer_view_model.dart';

void main() {
  group('TimerViewModel', () {
    late TimerViewModel timerViewModel;
    late ValueNotifier<bool> isPaused;

    setUp(() {
      timerViewModel = TimerViewModel();
      isPaused = ValueNotifier<bool>(false);
    });

    test("Verifica estado inicial do timer", () {
      expect(timerViewModel.isRunning, isFalse);
      expect(timerViewModel.currentTime, Duration.zero);
    });

    group("startTimer", () {
      test("Verifica inicialização do timer", () {
        timerViewModel.startTimer(5, isPaused);
        expect(timerViewModel.isRunning, isTrue);
        expect(timerViewModel.currentTime, Duration.zero);
      });

      test("Verifica se contador é zerado ao inicializar o timer", () {
        timerViewModel.currentTime = Duration(minutes: 10);
        timerViewModel.startTimer(5, isPaused);
        expect(timerViewModel.isRunning, isTrue);
        expect(timerViewModel.currentTime, Duration.zero);
      });

      test(
        "Verifica se contador é incrementa a cada segundo quando não está pausado",
        () async {
          timerViewModel.startTimer(5, isPaused);
          await Future.delayed(Duration(seconds: 1));
          expect(timerViewModel.currentTime, Duration(seconds: 1));
        },
      );

      test(
        "Verifica se contador é não incrementa quando está pausado",
        () async {
          timerViewModel.startTimer(5, isPaused);
          isPaused.value = true;
          await Future.delayed(Duration(seconds: 1));
          expect(timerViewModel.currentTime, Duration(seconds: 0));
          isPaused.value = false;
          await Future.delayed(Duration(seconds: 1));
          expect(timerViewModel.currentTime, Duration(seconds: 1));
        },
      );
    });

    group('stopTimer', () {
      test("verifica se o timer é encerrado", () {
        timerViewModel.startTimer(5, isPaused);
        expect(timerViewModel.isRunning, isTrue);
        timerViewModel.stopTimer();
        expect(timerViewModel.isRunning, isFalse);
      });
    });
  });
}
