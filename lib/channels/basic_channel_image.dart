import 'package:flutter/services.dart';

class BasicChannelImage {
  // Declare a private static constant for the BasicMessageChannel
  static const _basicMessageChannel =
    BasicMessageChannel<dynamic>('platformImageDemo', StandardMessageCodec(),);

  // Define a static method to request and receive an image from the platform
  static Future<Uint8List> getImage() async {
    // Send a message to request an image from the platform using the BasicMessageChannel.
    final reply = await _basicMessageChannel.send('getImage') as Uint8List?;
    
    // Check if the reply is null, indicating an error in loading the image.
    if (reply == null) {
      // If null, throw a PlatformException to indicate an error.
      throw PlatformException(
        code: 'Error',
        message: 'Failed to load Platform Image',
        details: null,
      );
    }
    
    // Return the received image data as a Uint8List.
    return reply;
  }
}