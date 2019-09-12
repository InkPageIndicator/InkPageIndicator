//
//  Logger.swift
//  Example
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import Foundation

final class Logger {
    
    private init() { }

    static func log(message: String = "") {
        _log(message: "\(Timestamp.timestamp()): \(message)")
    }
    
    static func log(tag: String = "", message: String = "") {
        _log(message: "\(Timestamp.timestamp()): [\(tag)] \(message)")
    }
    
    static private func _log(message: String) {
        #if DEBUG
        print(message)
        #endif
    }
    private final class Timestamp {
        private static var formatter: DateFormatter  = DateFormatter()
        
        static func timestamp(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss.SSS") -> String {
            formatter.dateFormat = dateFormat
            return formatter.string(from: Date())
        }
    }
}
