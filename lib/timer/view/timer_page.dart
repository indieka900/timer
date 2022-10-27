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
          //const Background(),
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
    final minuteStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$minuteStr : $secondStr',
      style: Theme.of(context).textTheme.headline1,
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
                onPressed: () => context
                    .read<TimerBloc>()
                    .add(TimerStarted(duration: state.duration)),
                child: Icon(Icons.play_arrow),
              ),
            ],
            if (state is TimerRunInProgress) ...[
              FloatingActionButton(
                onPressed: () => context.read<TimerBloc>().add(TimerPaused()),
                child: Icon(Icons.pause),
              ),
              FloatingActionButton(
                onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                child: Icon(Icons.replay),
              )
            ],
            if (state is TimerRunPause) ...[
              FloatingActionButton(
                onPressed: () => context.read<TimerBloc>().add(TimerResumed()),
                child: Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                onPressed: () => context.read<TimerBloc>().add(TimerReset()),
                child: Icon(Icons.replay),
              ),
            ],
            if (state is TimerRunComplete) ...[
              FloatingActionButton(
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
