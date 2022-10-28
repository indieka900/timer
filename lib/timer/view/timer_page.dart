import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/ticker.dart';
import 'package:flutter_timer/timer/bloc/timer_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(
        ticker: Ticker(),
      ),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter Timer'),
      ),
      body: Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: TimerText(),
                ),
              ),
              Actions(),
            ],
          )
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final hourStr = ((duration / 60) / 60).floor().toString().padLeft(2, '0');
    final minuteStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondStr = ((duration % 60) % 60).floor().toString().padLeft(2, '0');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 46, 85, 24),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              blurStyle: BlurStyle.solid,
              color: Color.fromARGB(255, 158, 231, 160),
            ),
          ]),
      child: Text(
        '$hourStr:$minuteStr:$secondStr',
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (previous, state) => previous.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state is TimerInitial) ...[
              FloatingActionButton(
                backgroundColor: Colors.greenAccent,
                tooltip: 'START',
                onPressed: () => context
                    .read<TimerBloc>()
                    .add(TimerStarted(duration: state.duration)),
                child: Icon(Icons.play_arrow),
              ),
            ],
            if (state is TimerRunInProgress) ...[
              FloatingActionButton(
                tooltip: 'PAUSE',
                backgroundColor: Colors.greenAccent,
                onPressed: () => context.read<TimerBloc>().add(TimerPaused()),
                child: Icon(Icons.pause),
              ),
              FloatingActionButton(
                tooltip: 'RESTART',
                backgroundColor: Colors.greenAccent,
                onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                child: Icon(Icons.replay),
              )
            ],
            if (state is TimerRunPause) ...[
              FloatingActionButton(
                tooltip: 'START',
                backgroundColor: Colors.greenAccent,
                onPressed: () => context.read<TimerBloc>().add(TimerResumed()),
                child: Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                tooltip: 'RESTART',
                backgroundColor: Colors.greenAccent,
                onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                child: Icon(Icons.replay),
              ),
            ],
            if (state is TimerRunComplete) ...[
              FloatingActionButton(
                tooltip: 'RESTART',
                backgroundColor: Colors.greenAccent,
                onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                child: Icon(Icons.replay),
              )
            ]
          ],
        );
      },
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 206, 98, 143),
            Color.fromARGB(255, 189, 33, 98),
            Color.fromARGB(255, 134, 6, 60),
            Color.fromARGB(255, 70, 2, 28),
            Color.fromARGB(255, 32, 2, 13),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
