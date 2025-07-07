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

    @ObservedObject var gameState: GameState
    @State private var navigateToResult = false

    var body: some View {
        NavigationStack {
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

                    Text("현재 점수: \(score)점")
                        .font(.headline)

                    // 라이프가 남아 있을 때만 다음 문제 버튼 표시
                    if gameState.life > 0 {
                        Button("다음 문제") {
                            onNext()
                        }
                        .buttonStyle(.borderedProminent)
                    } else {
                        Text("라이프가 모두 소진되어 게임이 종료됩니다.")
                            .foregroundColor(.red)
                            .font(.subheadline)
                    }
                }
                .padding()
            }

            // ✅ 라이프가 0일 경우 ResultView로 자동 이동
            .onAppear {
                if gameState.life == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        navigateToResult = true
                    }
                }
            }

            // ✅ 자동 이동할 destination
            .navigationDestination(isPresented: $navigateToResult) {
                ResultView(score: score)
            }
        }
    }
}
