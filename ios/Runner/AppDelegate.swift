import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let flutterViewController = self.window.rootViewController as! FlutterViewController
        
      // Configure the binary messenger to handle messages from Flutter.
      let binaryMessenger = flutterViewController.engine!.binaryMessenger
      binaryMessenger.setMessageHandlerOnChannel("foo", binaryMessageHandler: { message, reply in
          // Ensure proper byte order.
               guard let message = message else {
                   reply(nil)
                   return
               }
               // Decode the binary data to UTF-8 string.
               if let data = String(data: message, encoding: .utf8) {
                   let x = message.debugDescription // Convert the message to a string for demonstration.
                   // Display an alert with the received message.
                   let alertController = UIAlertController(
                       title: "Message from Flutter",
                       message: data,
                       preferredStyle: .alert
                   )
                   alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   flutterViewController.present(alertController, animated: true, completion: nil)
               }
               reply(nil)
      }
    )
      
      
      // FlutterMethodChannel to handle communication between Flutter and the platform.
      FlutterMethodChannel(name: "methodChannelDemo", binaryMessenger: binaryMessenger)
          .setMethodCallHandler { call, result in
              //call represents the incoming method call from Flutter
              //result represents result or response that you send back to Flutter after handling the method call.
              // Retrieve the 'count' argument from the method call, if provided.
              let count = (call.arguments as? NSDictionary)?["count"] as? Int
              
              // Determine which method was called from Flutter.
              switch call.method {
              case "random":
                  // Generate a random number between 0 and 100 and send it back to Flutter as a result.
                  result(Int.random(in: 0..<100))
              case "increment", "decrement":
                  if count == nil {
                      // If the 'count' argument is missing or invalid, send a FlutterError back to Flutter.
                      result(FlutterError(code: "INVALID ARGUMENT", message: "Invalid Argument", details: nil))
                  } else {
                      // If the 'count' argument is valid, perform the requested operation.
                      let updatedCount = call.method == "increment" ? count! + 1 : count! - 1
                      result(updatedCount)
                  }
              default:
                  // Handle any other method calls that are not implemented.
                  result(FlutterMethodNotImplemented)
              }
          }
      
      //Event Channel
      FlutterEventChannel(name: "eventChannelTimer", binaryMessenger: flutterViewController.binaryMessenger)
          .setStreamHandler(CustomEventHandler())
      
      //BasicMessage Channel
      FlutterBasicMessageChannel(name: "platformImageDemo", binaryMessenger: flutterViewController.binaryMessenger, codec: FlutterStandardMessageCodec.sharedInstance()).setMessageHandler{
          (message: Any?, reply: FlutterReply) -> Void in
           // Handle incoming messages from Flutter and reply to them
          if(message as! String == "getImage") {
              // Handle incoming messages from Flutter and reply to them
              guard let image = UIImage(named: "flutter") else {
                  reply(nil)
                  return
              }
              // If the image is successfully loaded, encode it as bytes and reply with it
              reply(FlutterStandardTypedData(bytes: image.jpegData(compressionQuality: 1)!))
          }
      }
      
            
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    

    // Function to decode a ByteBuffer into a UTF-8 string.
    private func decodeUtf8String(byteBuffer: FlutterStandardTypedData) -> String? {
            let byteArray = [UInt8](byteBuffer.data)
            return  String(bytes: byteArray, encoding: .utf8)
    }
}
