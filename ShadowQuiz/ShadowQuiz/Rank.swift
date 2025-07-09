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
  @Attribute(.unique) var id: UUID
  var nickName: String
  var score: Int
  
  init(id: UUID = UUID(), nickName: String, score: Int) {
    self.id = id
    self.nickName = nickName
    self.score = score
  }
}
