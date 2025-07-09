//
//  testAnswerResultView.swift
//  ShadowQuiz
//
//  Created by dkkim on 7/9/25.
//

import SwiftUI

struct testAnswerResultView: View {
    let score: Int
    let isCorrect: Bool
    let correctImageName: String
    let correctText: String
    let selectedLevelDefult: String
    let selectedSubjectDefult: String

    let onNext: () -> Void
    let onFinish: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Text(isCorrect ? "정답입니다!" : "오답입니다")
                .font(.largeTitle)
                .foregroundColor(isCorrect ? .green : .red)
                .bold()
            Image(correctImageName)
                .resizable()
                .scaledToFit()
                .frame(height: 250)
            Text("정답: \(correctText)").font(.title2)
            Text("현재 점수: \(score)점").font(.title3)
            HStack(spacing: 20) {
                Button("다음 문제") {
                    onNext()
                }.buttonStyle(.borderedProminent)
                Button("게임 종료") {
                    onFinish()
                }.buttonStyle(.bordered)
            }
        }
        .padding()
    }
}
