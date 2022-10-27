import 'package:flutter/material.dart';
import 'package:flutter_timer/timer/view/timer_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Flutter timer',
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 179, 93, 206),
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Color.fromARGB(255, 0, 255, 8),
              fontSize: 27,
              fontWeight: FontWeight.w600,
            ),
          ),
          textTheme: TextTheme(
            headline2: TextStyle(
              color: Color.fromARGB(255, 180, 250, 123),
            ),
          ),
          colorScheme:
              ColorScheme.light(secondary: Color.fromARGB(255, 222, 233, 164))),
      home: const TimerPage(),
    );
  }
}
