import 'package:flutter/services.dart'; 
class MethodChannelCounter {
  // Create a method channel with the channel name "methodChannelDemo"
  static MethodChannel methodChannel = const MethodChannel('methodChannelDemo');

  // Define a method to increment the counter on the native side
  static Future<int> increment({required int counterValue}) async {
    // Invoke the 'increment' method on the native side with the 'count' argument
    final result = await methodChannel.invokeMethod<int>('increment', {'count': counterValue});
    
    // Return the result received from the native side
    return result!;
  }

  // Define a method to decrement the counter on the native side
  static Future<int> decrement({required int counterValue}) async {
    // Invoke the 'decrement' method on the native side with the 'count' argument
    final result = await methodChannel.invokeMethod<int>('decrement', {'count': counterValue});
    
    // Return the result received from the native side
    return result!;
  }

  // Define a method to retrieve a random value from the native side
  static Future<int> randomValue() async {
    // Invoke the 'random' method on the native side
    final result = await methodChannel.invokeMethod<int>('random');
    
    // Return the result received from the native side
    return result!;
  }

  // Define a method 'tryMe' (custom method) to interact with the native side
  static Future<int> tryMe() async {
    // Invoke the 'tryMe' custom method on the native side
    final result = await methodChannel.invokeMethod<int>('tryMe');
    
    // Return the result received from the native side
    return result!;
  }
}
