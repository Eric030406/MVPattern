//
//  MeetingModel.swift
//  Macro
//
//  Created by Eric on 9/28/23.
//

import Combine
import SwiftUI

class MeetingModel: ObservableObject {
    @Published var meetings: [Meeting] = []
    @Published var timer: TimerManager
    
    init(timer: TimerManager) {
        self.timer = timer
        self.timer.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send() }
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
}
