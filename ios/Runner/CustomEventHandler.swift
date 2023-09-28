//
//  CustomEventHandler.swift
//  Runner
//
//  Created by Safal Shrestha on 01/09/2023.
//

import Foundation

class CustomEventHandler: NSObject,FlutterStreamHandler{
    
    private var counter = 0
    private var timer: Timer?

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        events(counter)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
           events(self.counter)
           self.counter += 1
       }
       return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        timer?.invalidate()
              timer = nil
              return nil
    }
    
    
}
