//
//  PlaySettings.swift
//  ShadowQuiz
//
//  Created by 유재환 on 7/9/25.
//

import Foundation
import SwiftData

@Model
class GameSettings {
    var level: String // 난이도 프로퍼티
    var topic: String // 주제 프로퍼티
    
    // 초기화
    init(level: String, topic: String) {
        self.level = level
        self.topic = topic
    }
}
