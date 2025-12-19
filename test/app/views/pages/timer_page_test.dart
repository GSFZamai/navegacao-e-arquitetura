import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/shared/enums/timer_type.dart';
import 'package:fokus/app/view_models/timer_view_model.dart';
import 'package:fokus/app/views/pages/timer_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockTimerViewModel extends Mock implements TimerViewModel {}

void main() {
  late TimerViewModel timerViewModel;
  final MockTimerViewModel mockTimerViewModel = MockTimerViewModel();
  Widget createWidget({
    TimerType timerType = TimerType.focus,
    TimerViewModel? timerViewModel,
  }) {
    return ChangeNotifierProvider.value(
      value: timerViewModel ??= mockTimerViewModel,
      child: MaterialApp(
        home: Scaffold(body: TimerPage(timerType: timerType)),
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(ValueNotifier<bool>(false));
  });

  setUp(() {
    timerViewModel = TimerViewModel();
    when(() => mockTimerViewModel.currentTime).thenReturn(Duration.zero);
    when(() => mockTimerViewModel.isRunning).thenReturn(false);
  });

  group("TimerPage", () {
    group("TimerType - Focus", () {
      testWidgets(
        'Verifica se o método startTimer foi chamado com argumento initialMinutes = 25',
        (tester) async {
          await tester.pumpWidget(createWidget());
          final startButton = find.text("Iniciar");

          await tester.tap(startButton);
          verify(() => mockTimerViewModel.startTimer(25, any())).called(1);
        },
      );
      testWidgets('Verifica se o método stopTimer foi chamado', (tester) async {
        await tester.pumpWidget(createWidget());
        final startButton = find.text("Iniciar");
        final stopButton = find.text("Parar");

        await tester.tap(startButton);
        await tester.pump(Duration(seconds: 5));
        await tester.tap(stopButton);
        verify(() => mockTimerViewModel.stopTimer()).called(1);
      });
    });
  });
}
