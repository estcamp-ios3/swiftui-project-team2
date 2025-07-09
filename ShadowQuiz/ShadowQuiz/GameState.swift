//
//  GameState.swift
//  ShadowQuiz
//
//  Created by dkkim on 7/7/25.
//



// 게임 데이터(점수, 라이프, 타이머 여기에 입력하고 연결시키기)
import Foundation
import Combine

import SwiftUI

class GameState: ObservableObject {
    @Published var score: Int = 0
    @Published var life: Int = 3
    @Published var timeRemaining: Int = 0

    private var timer: Timer?
    private var timerStarted = false // ✅ 중복 방지용

    func startTimer(duration: Int, onTimeUp: @escaping () -> Void) {
        guard !timerStarted else { return } // ✅ 이미 시작했다면 무시
        timeRemaining = duration
        timerStarted = true

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            DispatchQueue.main.async {
                self.timeRemaining -= 1
                if self.timeRemaining <= 0 {
                    self.timer?.invalidate()
                    self.timerStarted = false
                    onTimeUp()
                }
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerStarted = false
    }
}
