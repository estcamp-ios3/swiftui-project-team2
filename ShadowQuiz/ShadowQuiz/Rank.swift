//
//  Rank.swift
//  ShadowQuiz
//
//  Created by 권태우 on 7/8/25.
//

import SwiftUI
import SwiftData

@Model
class Rank {
    @Attribute(.unique) var nickName: String
    var score: Int?
}
