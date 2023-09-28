package com.example.channel_demo


import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import java.io.InputStream
import java.nio.ByteBuffer
import java.nio.ByteOrder
import kotlin.random.Random


class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        //BinaryMessenger
        flutterEngine.dartExecutor.binaryMessenger.setMessageHandler("foo") { message, reply ->
            message?.order(ByteOrder.nativeOrder()) // Ensure proper byte order.
            val data = decodeUtf8String(message!!) // Decode the binary data to UTF-8 string.
            val x = message.toString() // Convert the message to a string for demonstration.
            // Display a Toast with the received message.
            Toast.makeText(this, "Received message from Flutter: $data", Toast.LENGTH_SHORT).show()
            reply.reply(null)
        }

        // MethodChannel to handle communication between Flutter and the platform.
        MethodChannel(flutterEngine.dartExecutor, "methodChannelDemo")
            .setMethodCallHandler { call, result ->
                //call represents the incoming method call like method name, and arguments from Flutter
                //result represents result or response that you send back to Flutter after handling the method call.
                // Retrieve the 'count' argument from the method call, if provided.
                val count: Int? = call.argument<Int>("count")
                // Determine which method was called from Flutter.
                when (call.method) {
                    // Handle the 'random' method call.
                    "random" -> {
                        // Generate a random number between 0 and 100 and send it back to Flutter as a success result.
                        result.success(Random(System.nanoTime()).nextInt(0, 100))
                    }
                    // Handle the 'increment' and 'decrement' method calls.
                    "increment", "decrement" -> {
                        // Check if the 'count' argument is missing or invalid.
                        if (count == null) {
                            // If the 'count' argument is missing or invalid, send an error result to Flutter.
                            result.error("INVALID ARGUMENT", "Invalid Argument", null)
                        } else {
                            // If the 'count' argument is valid, perform the requested operation.
                            if (call.method == "increment") {
                                // Increment the 'count' and send the updated value to Flutter as a success result.
                                result.success(count + 1)
                            } else {
                                // Decrement the 'count' and send the updated value to Flutter as a success result.
                                result.success(count - 1)
                            }
                        }
                    }
                    // Handle any other method calls that are not implemented.
                    else -> {
                        // Send a "not implemented" result to Flutter.
                        result.notImplemented()
                    }
                }
            }

        //Event Channel
        EventChannel(flutterEngine.dartExecutor, "eventChannelTimer")
            .setStreamHandler(CustomStreamHandler())

        //BasicMessageChannel
        BasicMessageChannel(flutterEngine.dartExecutor, "platformImageDemo", StandardMessageCodec())
            .setMessageHandler { message, reply ->
                //message represents the incoming message from Flutter
                //result represents result or response that you send back to Flutter after handling the method call.
                // Toast message indicating the received message from Flutter.
                Toast.makeText(this, "Received message from Flutter: $message", Toast.LENGTH_SHORT).show();
                // Check if the received message is "getImage."
                if (message == "getImage") {
                    // Open the image file from the Android app's assets.
                    val inputStream: InputStream = assets.open("flutter.png")
                    // Read the image data from the input stream and send it as a reply.
                    reply.reply(inputStream.readBytes())
                }
            }

        super.configureFlutterEngine(flutterEngine)
    }

    private fun decodeUtf8String(byteBuffer: ByteBuffer): String {
        return try {
            val byteArray = ByteArray(byteBuffer.remaining())
            byteBuffer.get(byteArray)
            String(byteArray, Charsets.UTF_8)
        } catch (e: Exception) {
            e.printStackTrace()
            ""
        }
    }
}
