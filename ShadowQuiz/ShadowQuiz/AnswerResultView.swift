//
//  AnswerResultView.swift
//  0707project
//
//  Created by dkkim on 7/7/25.
//

import SwiftUI

struct AnswerResultView: View {
    let isCorrect: Bool
    let correctImageName: String
    let correctText: String

    var body: some View {
        VStack(spacing: 20) {
            Text(isCorrect ? "정답입니다! 🎉" : "오답입니다 😢")
                .font(.title)
                .foregroundColor(isCorrect ? .green : .red)
                .bold()

            Image(correctImageName)
                .resizable()
                .scaledToFit()
                .frame(height: 250)

            Text("정답: \(correctText)")
                .font(.headline)

            NavigationLink("다음 문제", destination: GamePlayView(
                questionImageName: "nextSilhouette",
                correctAnswer: "홍길순",
                hint: "아이돌 출신 배우"
            ))
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}




