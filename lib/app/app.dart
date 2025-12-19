import 'package:flutter/material.dart';
import 'package:fokus/app/shared/enums/timer_type.dart';
import 'package:fokus/app/view_models/timer_view_model.dart';
import 'package:fokus/app/views/pages/home_page.dart';
import 'package:fokus/app/views/pages/timer_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerViewModel(),
      child: MaterialApp(
        title: 'Fokus',
        routes: {
          "/home": (context) => HomePage(),
          "/timer": (context) => TimerPage(
            timerType:
                ModalRoute.of(context)?.settings.arguments as TimerType? ??
                TimerType.focus,
          ),
        },
        theme: ThemeData(useMaterial3: true),
        initialRoute: "/home",
      ),
    );
  }
}
