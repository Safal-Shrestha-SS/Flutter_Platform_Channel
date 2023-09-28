package com.example.channel_demo

import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class CustomStreamHandler : EventChannel.StreamHandler {

    private val job = SupervisorJob()
    private val scope = CoroutineScope(Dispatchers.Default + job)
    private var isListening = false
    private var counter = 0

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        if (events != null) {
            isListening = true
            scope.launch {
                while (isListening) {
                    // Generate your value (e.g., timer value) here
                    val value = counter++
                    withContext(Dispatchers.Main) {
                        events.success(value)
                    }
                    delay(1000) // Send value every 1000 milliseconds (1 second)
                }
            }
        }

    }
    override fun onCancel(arguments: Any?) {
        isListening = false
    }

}
