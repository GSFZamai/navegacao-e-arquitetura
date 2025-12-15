import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/view_models/timer_view_model.dart';
import 'package:fokus/app/views/widgets/timer_widget.dart';
import 'package:mocktail/mocktail.dart';

class MockTimerViewModel extends Mock implements TimerViewModel {}

void main() {
  final MockTimerViewModel mockTimerViewModel = MockTimerViewModel();
  late TimerViewModel timerViewModel = TimerViewModel();

  Widget createWidget({required TimerViewModel timerViewModel}) {
    return MaterialApp(
      home: Scaffold(
        body: TimerWidget(initialMinutes: 1, timerViewModel: timerViewModel),
      ),
    );
  }

  setUp(() {
    when(() => mockTimerViewModel.currentTime).thenReturn(Duration.zero);
    when(() => mockTimerViewModel.isRunning).thenReturn(false);
  });

  setUpAll(() {
    registerFallbackValue(ValueNotifier<bool>(false));
  });

  group("TimerWidget", () {
    testWidgets('Exibe tempo inicial zerado TimerWidget', (tester) async {
      await tester.pumpWidget(createWidget(timerViewModel: timerViewModel));

      expect(find.text("00:00"), findsOneWidget);
    });

    group("startTimer", () {
      testWidgets('Deve chamar método startTimer do widget TimerWidget', (
        tester,
      ) async {
        await tester.pumpWidget(
          createWidget(timerViewModel: mockTimerViewModel),
        );

        final botaoIniciar = find.text("Iniciar");

        expect(botaoIniciar, findsOneWidget);

        await tester.tap(botaoIniciar);
        await tester.pumpAndSettle();
        verify(() => mockTimerViewModel.startTimer(any(), any())).called(1);
      });

      testWidgets("Deve atualizar Widget e iniciar contagem", (tester) async {
        await tester.pumpWidget(createWidget(timerViewModel: timerViewModel));
        final botaoIniciar = find.text("Iniciar");
        final botaoParar = find.text("Parar");
        final botaoPausar = find.text("Pausar");

        await tester.tap(botaoIniciar);
        await tester.pumpAndSettle();
        await tester.pump(Duration(seconds: 10));

        final timerDisplay = find.text("00:10");
        expect(botaoIniciar, findsNothing);
        expect(timerDisplay, findsOneWidget);
        expect(botaoPausar, findsOneWidget);
        expect(botaoParar, findsOneWidget);
      });
    });

    testWidgets(
      "Deve pausar contagem quando clicar em Pausar e retomar contagem ao clicar em Continuar",
      (tester) async {
        await tester.pumpWidget(createWidget(timerViewModel: timerViewModel));
        final botaoIniciar = find.text("Iniciar");
        final botaoPausar = find.text("Pausar");
        final botaoContinuar = find.text("Continuar");
        final timerDisplayWith10 = find.text("00:10");
        final timerDisplayWith20 = find.text("00:20");

        await tester.tap(botaoIniciar);
        await tester.pump(Duration(seconds: 10));

        expect(timerDisplayWith10, findsOneWidget);

        await tester.tap(botaoPausar);
        await tester.pump(Duration(seconds: 10));

        expect(botaoContinuar, findsOneWidget);
        expect(botaoPausar, findsNothing);
        expect(timerDisplayWith10, findsOneWidget);

        await tester.tap(botaoContinuar);
        await tester.pump(Duration(seconds: 10));
        expect(timerDisplayWith20, findsOneWidget);
      },
    );

    testWidgets("Deve parar contagem quando clicar em Parar e recomeçar", (
      tester,
    ) async {
      await tester.pumpWidget(createWidget(timerViewModel: timerViewModel));
      final botaoIniciar = find.text("Iniciar");
      final botaoParar = find.text("Parar");
      final timerDisplayWith0 = find.text("00:00");
      final timerDisplayWith10 = find.text("00:10");

      await tester.tap(botaoIniciar);
      await tester.pump(Duration(seconds: 10));

      expect(botaoParar, findsOneWidget);

      await tester.tap(botaoParar);
      await tester.pumpAndSettle();

      expect(timerViewModel.isRunning, isFalse);
      expect(timerDisplayWith10, findsOneWidget);

      await tester.tap(botaoIniciar);
      await tester.pump();
      expect(timerDisplayWith0, findsOneWidget);
    });
  });
}
