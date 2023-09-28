import 'package:flutter/services.dart';

class EventChannelTimer {
  // Create the EventChannel with the specified name "eventChannelTimer".
  static const _eventChannelCustom = EventChannel('eventChannelTimer');

  // Create a method to get the timerValue stream.
  static Stream<int> get timerValue {
   // Use the receiveBroadcastStream method to create a stream of events from the platform side.
    // Map the dynamic events to integers as they are received.
    return _eventChannelCustom.receiveBroadcastStream().map(
          (dynamic event) => event as int,
    );
  }

}
