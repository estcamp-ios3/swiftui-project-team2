//
//  QuizItem.swift
//  ShadowQuiz
//
//  Created by dkkim on 7/7/25.
//

import Foundation

struct QuizItem: Identifiable, Equatable {
    let id = UUID()
    let imageName: String // 실루엣 이미지
    let answerImageName: String // 정답 이미지
    let answer: String
    let hint: String
    let category: String  // 주제 구분용 (예: "포켓몬", "공룡", "사물", "동물")
}
