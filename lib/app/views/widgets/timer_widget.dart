import 'package:flutter/material.dart';
import 'package:fokus/app/shared/utils/app_config.dart';
import 'package:fokus/app/view_models/timer_view_model.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatefulWidget {
  final int initialMinutes;

  const TimerWidget({super.key, required this.initialMinutes});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late TimerViewModel timerViewModel;
  ValueNotifier<bool> isPaused = ValueNotifier(false);

  @override
  void initState() {
    timerViewModel = Provider.of<TimerViewModel>(context, listen: false);
    super.initState();
  }

  void onPressButton() {
    if (timerViewModel.isRunning) {
      timerViewModel.stopTimer();
    } else {
      timerViewModel.startTimer(widget.initialMinutes, isPaused);
    }
    isPaused.value = false;
  }

  void onPressPauseButton() {
    isPaused.value = !isPaused.value;
  }

  @override
  void dispose() {
    timerViewModel.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(20, 68, 128, 0.5),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xff144480), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Timer
          AnimatedBuilder(
            animation: timerViewModel,
            builder: (context, child) {
              final currentTime = timerViewModel.currentTime;
              return Text(
                "${currentTime.inMinutes.toString().padLeft(2, "0")}:${(currentTime.inSeconds % 60).toString().padLeft(2, "0")}",
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              );
            },
          ),
          const SizedBox(height: 40),

          // Botões de controle
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ListenableBuilder(
              listenable: timerViewModel,
              builder: (context, child) {
                final isRunning = timerViewModel.isRunning;
                return ElevatedButton(
                  onPressed: () {
                    onPressButton();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRunning
                        ? Colors.red
                        : AppConfig.buttonColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isRunning ? Icons.stop : Icons.play_arrow,
                        color: AppConfig.backgroundColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isRunning ? "Parar" : "Iniciar",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppConfig.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ListenableBuilder(
            listenable: timerViewModel,
            builder: (context, child) {
              final isRunning = timerViewModel.isRunning;
              if (!isRunning) return SizedBox.shrink();
              return ValueListenableBuilder(
                valueListenable: isPaused,
                builder: (context, value, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        onPressPauseButton();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConfig.buttonColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            value ? Icons.play_arrow : Icons.pause,
                            color: AppConfig.backgroundColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            value ? "Continuar" : "Pausar",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppConfig.backgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
