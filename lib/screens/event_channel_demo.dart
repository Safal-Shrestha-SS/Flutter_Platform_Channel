import 'package:channel_demo/channels/event_channel_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventChannelDemo extends StatefulWidget {
  const EventChannelDemo({super.key});

  @override
  State<EventChannelDemo> createState() => _EventChannelDemoState();
}

class _EventChannelDemoState extends State<EventChannelDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Event Channel Demo"),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: EventChannelTimer.timerValue,
          builder: (context, snapshot) {
            return switch (snapshot) {
              AsyncSnapshot(hasError: true) =>
                  Text((snapshot.error as PlatformException).message!),
              AsyncSnapshot(hasData: true) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Data: ${snapshot.data!.toStringAsFixed(3)}',
                      style: const TextStyle(fontSize: 32)),
                ],
              ),
              _ =>
              const Text('No Data Available', style: TextStyle(fontSize: 32)),
            };
          },
        ),
      ),
    );
  }
}
