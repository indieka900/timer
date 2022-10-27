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
        primaryColor: Color.fromARGB(255, 102, 63, 114),
        colorScheme: ColorScheme.light(
          secondary: Color.fromARGB(255, 83, 75, 75)
        )
      ),
      home: const TimerPage(),
    );
  }
}
