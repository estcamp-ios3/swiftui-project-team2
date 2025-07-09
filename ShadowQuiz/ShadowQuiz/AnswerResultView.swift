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
    let score: Int
    let correctText: String
    let onNext: () -> Void
    let gameState: GameState  // 필요시 사용

    var body: some View {
        ZStack {
            Color(hex: "#CBEFB9").opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text(isCorrect ? "정답입니다!" : "오답입니다.")
                    .font(.title)
                    .foregroundColor(isCorrect ? .green : .red)

                Image(correctImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)

                Text("정답: \(correctText)")
                    .font(.title2)

                Button("다음 문제") {
                    onNext()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
