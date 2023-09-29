//
//  TimerView.swift
//  Macro
//
//  Created by Eric on 9/29/23.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var meetingModel: MeetingModel
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack {
            Text(remainingTime)
                .font(.system(size: 100))
            
            HStack {
                startButton
                stopButton
                resumeButton
                resetButton
            }
            Text(errorMessage)
        }
        .padding()

    }
    
    private var remainingTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: TimeInterval(meetingModel.timer.remainingTime))!
    }
    
    private var startButton: some View {
        Button {
            switch meetingModel.timer.start(minutes: 1) {
            case .success(.run):
                errorMessage = "시작"
            case .failure(.unintended):
                errorMessage = TimerError.unintended.localizedDescription
            default:
                errorMessage = TimerError.unintended.localizedDescription
            }
            
        } label: {
            Text("회의 시작하기")
        }
    }
    
    private var stopButton: some View {
        Button {
            timerAction(meetingModel.timer.pause)
        } label: {
            Text("회의 중단")
        }
    }
    
    private var resumeButton: some View {
        Button {
            timerAction(meetingModel.timer.resume)
        } label: {
            Text("이어하기")
        }
    }
    
    private var resetButton: some View {
        Button {
            timerAction(meetingModel.timer.reset)
        } label: {
            Text("타이머 종료")
        }
    }
    
    private func timerAction(_ action: () -> Result<TimerState, TimerError>) {
        switch action() {
        case .success(.run):
            errorMessage = "재시작"
        case .success(.pause):
            errorMessage = "정지"
        case .success(.reset):
            errorMessage = "끝"
        case .failure(.unintended):
            errorMessage = TimerError.unintended.localizedDescription
        }
    }
}

#Preview {
    TimerView()
        .environmentObject(TimerManager())
        .environmentObject(MeetingModel())
}
