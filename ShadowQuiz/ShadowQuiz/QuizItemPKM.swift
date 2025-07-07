//
//  QuizItemPKM.swift
//  ShadowQuiz
//
//  Created by dkkim on 7/7/25.
//

import Foundation

struct QuizItemPKM: Identifiable {
    let id = UUID()
    let imageName: String
    let answer: String
    let hint: String
}

let quizList: [QuizItemPKM] = [
    QuizItemPKM(imageName: "pkmshadow01", answer: "골벳", hint: "This is a Pikachu"),
    QuizItemPKM(imageName: "pkmshadow02", answer: "고지", hint: "This is a Pikachu"),
    QuizItemPKM(imageName: "pkmshadow03", answer: "꼬렛", hint: "This is a Pikachu"),
    QuizItemPKM(imageName: "pkmshadow04", answer: "니드리노", hint: "This is a Pikachu"),
    QuizItemPKM(imageName: "pkmshadow05", answer: "골덕", hint: "This is a Pikachu"),
    QuizItemPKM(imageName: "pkmshadow06", answer: "콘치", hint: "This is a Pikachu"),
    
]
