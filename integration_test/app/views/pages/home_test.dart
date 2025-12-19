import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/app.dart';
import 'package:fokus/app/shared/enums/timer_type.dart';
import 'package:integration_test/common.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("home page", () {
    testWidgets('Should render Home page with one button for each TimerType', (
      tester,
    ) async {
      await tester.pumpWidget(App());

      expect(find.text(TimerType.focus.title), findsOneWidget);
      expect(find.text(TimerType.shortBreak.title), findsOneWidget);
      expect(find.text(TimerType.longBreak.title), findsOneWidget);
    });

    group("Should navigate to timer page with Focus params", () {
      testWidgets('Pause functionality should work correctly', (tester) async {
        await tester.pumpWidget(App());
        final focusButton = find.text(TimerType.focus.title);

        await tester.tap(focusButton);
        await tester.pumpAndSettle();

        final startButton = find.text("Iniciar");

        expect(find.text(TimerType.focus.title), findsOneWidget);
        expect(startButton, findsOneWidget);

        await tester.tap(startButton);
        await tester.pump(Duration(seconds: 2));

        final pauseButton = find.text("Pausar");
        final stopButton = find.text("Parar");
        final continueButton = find.text("Continuar");
        final displayTwoSeconds = find.textContaining("02");
        final displayFourSeconds = find.textContaining("04");

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayTwoSeconds, findsOneWidget);

        await tester.tap(pauseButton);
        await tester.pump(Duration(seconds: 2));

        expect(continueButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayTwoSeconds, findsOneWidget);

        await tester.tap(continueButton);
        await tester.pump(Duration(seconds: 2));

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayFourSeconds, findsOneWidget);
      });
      testWidgets('Stop functionality should work correctly', (tester) async {
        await tester.pumpWidget(App());
        final focusButton = find.text(TimerType.focus.title);

        await tester.tap(focusButton);
        await tester.pumpAndSettle();

        final startButton = find.text("Iniciar");

        expect(find.text(TimerType.focus.title), findsOneWidget);
        expect(startButton, findsOneWidget);

        await tester.tap(startButton);
        await tester.pump(Duration(seconds: 2));

        final pauseButton = find.text("Pausar");
        final stopButton = find.text("Parar");
        final continueButton = find.text("Continuar");
        final displayTwoSeconds = find.textContaining("02");
        final displayZeroSeconds = find.text("00:00");

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayTwoSeconds, findsOneWidget);

        await tester.tap(stopButton);
        await tester.pump(Duration(seconds: 2));

        expect(continueButton, findsNothing);
        expect(pauseButton, findsNothing);
        expect(startButton, findsOneWidget);

        await tester.tap(startButton);
        await tester.pumpAndSettle();

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayZeroSeconds, findsOneWidget);

        await tester.pump(Duration(seconds: 2));

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
      });
    });

    group("Should navigate to timer page with ShortBreak params", () {
      testWidgets('Pause functionality should work correctly', (tester) async {
        await tester.pumpWidget(App());
        final shortBreakButton = find.text(TimerType.shortBreak.title);

        await tester.tap(shortBreakButton);
        await tester.pumpAndSettle();

        final startButton = find.text("Iniciar");

        expect(find.text(TimerType.shortBreak.title), findsOneWidget);
        expect(startButton, findsOneWidget);

        await tester.tap(startButton);
        await tester.pump(Duration(seconds: 2));

        final pauseButton = find.text("Pausar");
        final stopButton = find.text("Parar");
        final continueButton = find.text("Continuar");
        final displayTwoSeconds = find.textContaining("02");
        final displayFourSeconds = find.textContaining("04");

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayTwoSeconds, findsOneWidget);

        await tester.tap(pauseButton);
        await tester.pump(Duration(seconds: 2));

        expect(continueButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayTwoSeconds, findsOneWidget);

        await tester.tap(continueButton);
        await tester.pump(Duration(seconds: 2));

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayFourSeconds, findsOneWidget);
      });
      testWidgets('Stop functionality should work correctly', (tester) async {
        await tester.pumpWidget(App());
        final shortBreakButton = find.text(TimerType.shortBreak.title);

        await tester.tap(shortBreakButton);
        await tester.pumpAndSettle();

        final startButton = find.text("Iniciar");

        expect(find.text(TimerType.shortBreak.title), findsOneWidget);
        expect(startButton, findsOneWidget);

        await tester.tap(startButton);
        await tester.pump(Duration(seconds: 2));

        final pauseButton = find.text("Pausar");
        final stopButton = find.text("Parar");
        final continueButton = find.text("Continuar");
        final displayTwoSeconds = find.textContaining("02");
        final displayZeroSeconds = find.text("00:00");

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayTwoSeconds, findsOneWidget);

        await tester.tap(stopButton);
        await tester.pump(Duration(seconds: 2));

        expect(continueButton, findsNothing);
        expect(pauseButton, findsNothing);
        expect(startButton, findsOneWidget);

        await tester.tap(startButton);
        await tester.pumpAndSettle();

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayZeroSeconds, findsOneWidget);

        await tester.pump(Duration(seconds: 2));

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
      });
    });

    group("Should navigate to timer page with LongBreak params", () {
      testWidgets('Pause functionality should work correctly', (tester) async {
        await tester.pumpWidget(App());
        final longBreakButton = find.text(TimerType.longBreak.title);

        await tester.tap(longBreakButton);
        await tester.pumpAndSettle();

        final startButton = find.text("Iniciar");

        expect(find.text(TimerType.longBreak.title), findsOneWidget);
        expect(startButton, findsOneWidget);

        await tester.tap(startButton);
        await tester.pump(Duration(seconds: 2));

        final pauseButton = find.text("Pausar");
        final stopButton = find.text("Parar");
        final continueButton = find.text("Continuar");
        final displayTwoSeconds = find.textContaining("02");
        final displayFourSeconds = find.textContaining("04");

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayTwoSeconds, findsOneWidget);

        await tester.tap(pauseButton);
        await tester.pump(Duration(seconds: 2));

        expect(continueButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayTwoSeconds, findsOneWidget);

        await tester.tap(continueButton);
        await tester.pump(Duration(seconds: 2));

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayFourSeconds, findsOneWidget);
      });
      testWidgets('Stop functionality should work correctly', (tester) async {
        await tester.pumpWidget(App());
        final longBreakButton = find.text(TimerType.longBreak.title);

        await tester.tap(longBreakButton);
        await tester.pumpAndSettle();

        final startButton = find.text("Iniciar");

        expect(find.text(TimerType.longBreak.title), findsOneWidget);
        expect(startButton, findsOneWidget);

        await tester.tap(startButton);
        await tester.pump(Duration(seconds: 2));

        final pauseButton = find.text("Pausar");
        final stopButton = find.text("Parar");
        final continueButton = find.text("Continuar");
        final displayTwoSeconds = find.textContaining("02");
        final displayZeroSeconds = find.text("00:00");

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayTwoSeconds, findsOneWidget);

        await tester.tap(stopButton);
        await tester.pump(Duration(seconds: 2));

        expect(continueButton, findsNothing);
        expect(pauseButton, findsNothing);
        expect(startButton, findsOneWidget);

        await tester.tap(startButton);
        await tester.pumpAndSettle();

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
        expect(displayZeroSeconds, findsOneWidget);

        await tester.pump(Duration(seconds: 2));

        expect(pauseButton, findsOneWidget);
        expect(stopButton, findsOneWidget);
      });
    });
  });
}
