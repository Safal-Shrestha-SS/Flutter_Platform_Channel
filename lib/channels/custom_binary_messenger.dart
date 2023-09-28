
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
class CustomBinaryMessenger {
  // A static method for sending a given value as a binary message.
  static Future<void> givenValue(String data) async {
    // Create a buffer to hold the binary data.
    final WriteBuffer buffer = WriteBuffer();
    // Convert the given data string into UTF-8 bytes.
    final List<int> utf8Bytes = utf8.encode(data);
    // Convert the UTF-8 bytes into an Uint8List.
    final Uint8List utf8Int8List = Uint8List.fromList(utf8Bytes);
    // Put the Uint8List into the buffer.
    buffer.putUint8List(utf8Int8List);
    // Get the final binary message data from the buffer.
    final ByteData message = buffer.done();
    // Send the binary message using the 'Messenger' class through chaneel `foo`.
    await Messenger().send('foo', message);
    return;
  }
}
// A custom implementation of the BinaryMessenger interface. I am only handling
// send here for the sake of example
class Messenger implements BinaryMessenger {
  @override
  // Handle incoming platform messages. In this case, it throws an unsupported error.
  Future<void> handlePlatformMessage(
      String channel, ByteData? data, PlatformMessageResponseCallback? callback) {
    throw UnsupportedError("This platform message handling is not supported.");
  }
  @override
  // Send a binary message to the platform using the 'ui.PlatformDispatcher'.
  Future<ByteData?>? send(String channel, ByteData? message) {
    // Use the 'ui.PlatformDispatcher' to send the platform message and handle the callback
    ui.PlatformDispatcher.instance.sendPlatformMessage(channel, message, (data) {});
    return null;
  }
  @override
  // Set a handler for incoming messages. In this case, it throws an unsupported error.
  void setMessageHandler(String channel, MessageHandler? handler) {
    throw UnsupportedError("Setting message handler is not supported.");
  }
}

