//
//  TimerModel.swift
//  Macro
//
//  Created by Eric on 9/28/23.
//

import SwiftUI

enum TimerState {
    case run
    case pause
    case reset
}

class TimerManager: ObservableObject {
    @Published var state: TimerState = .reset
    @Published var remainingTime: Int = 0
    private var timer: Timer?
    
    init() {
        self.timer = Timer()
    }
    
    func start(minutes seconds: Int) -> Result<TimerState, TimerError> {
        guard state == .reset else { return .failure(.unintended) }
        remainingTime = seconds * 60
        runTimer()
        
        return .success(TimerState.run)
    }
    
    func pause() -> Result<TimerState, TimerError> {
        guard state == .run else { return .failure(.unintended) }
        timer?.invalidate()
        updateTimerState(.pause)
        
        return .success(TimerState.pause)
    }
    
    func resume() -> Result<TimerState, TimerError> {
        guard state == .pause else { return .failure(.unintended) }
        runTimer()
        
        return .success(TimerState.run)
    }
    
    func reset() -> Result<TimerState, TimerError> {
        guard state == .pause else { return .failure(.unintended) }
        timer?.invalidate()
        timer = nil
        remainingTime = 0
        updateTimerState(.reset)
        
        return .success(TimerState.reset)
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            remainingTime -= 1
        })
        updateTimerState(.run)
    }
    
    private func updateTimerState(_ state: TimerState) {
        self.state = state
    }
}
