//
//  TimerError.swift
//  Macro
//
//  Created by Eric on 9/29/23.
//

import Foundation

enum TimerError: LocalizedError {
    case unintended
    
    var errorDescription: String? {
        switch self {
        case .unintended:
            return "의도하지 않은 동작입니다!!"
        }
    }
}
