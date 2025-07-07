//
//  GameState.swift
//  ShadowQuiz
//
//  Created by dkkim on 7/7/25.
//



// 게임 데이터(점수, 라이프, 타이머 여기에 입력하고 연결시키기)
import Foundation

import SwiftUI

class GameState: ObservableObject {
    @Published var score: Int = 0
    @Published var life: Int = 3
    @Published var timeRemaining: Int = 0
    
}
