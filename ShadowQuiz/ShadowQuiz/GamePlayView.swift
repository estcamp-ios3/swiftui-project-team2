//
//  GamePlayView.swift
//  0707project
//
//  Created by dkkim on 7/7/25.
//

import SwiftUI

// MARK: - 난이도 설정 열거형
enum QuizDifficulty: String {
    case easy = "하"
    case medium = "중"
    case hard = "상"

    var timeLimit: Int {
        switch self {
        case .easy: return 180
        case .medium: return 120
        case .hard: return 60
        }
    }

    var scorePerQuestion: Int {
        switch self {
        case .easy: return 10
        case .medium: return 20
        case .hard: return 30
        }
    }
}

// MARK: - GamePlayView
struct GamePlayView: View {
    @ObservedObject var gameState: GameState
    let difficulty: QuizDifficulty
    let selectedSubject: String

    @State private var quizItem: [QuizItem] = []
    @State private var currentIndex = 0
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var showHint = false
    @State private var showFinalResult = false
    @State private var timer: Timer?

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#CBEFB9").opacity(0.5).ignoresSafeArea()

                if currentIndex < quizItem.count {
                    let current = quizItem[currentIndex]

                    ScrollView {
                        VStack(spacing: 30) {
                            HStack {
                                Text("⏱ 남은 시간: \(gameState.timeRemaining)초")
                                    .font(.caption).bold()
                                Spacer()
                                Text("점수: \(gameState.score)")
                                    .font(.caption)
                                Text("LIFE:")
                                    .bold()

                                // ✅ 수정된 ForEach
                                ForEach(Array(0..<gameState.life), id: \.self) { _ in
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                }
                            }

                            Text("무엇 일까요?")
                                .font(.title).bold()

                            Image(current.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)

                            TextField("정답을 입력하세요", text: $userAnswer)
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)

                            HStack(spacing: 15) {
                                Button("히드") {
                                    showHint.toggle()
                                }
                                .buttonStyle(.bordered)

                                Button("패스") {
                                    let skipped = quizItem.remove(at: currentIndex)
                                    quizItem.append(skipped)
                                    if currentIndex >= quizItem.count {
                                        currentIndex = 0
                                    }
                                    userAnswer = ""
                                    showHint = false
                                }
                                .buttonStyle(.bordered)

                                Button("정답 제출") {
                                    handleAnswerSubmission(correctAnswer: current.answer)
                                }
                                .buttonStyle(.borderedProminent)
                            }

                            if showHint {
                                Text("히드: \(current.hint)")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                    }
                }
            }

            .navigationDestination(isPresented: $showResult) {
                if currentIndex < quizItem.count {
                    let current = quizItem[currentIndex]
                    AnswerResultView(
                        isCorrect: isCorrect,
                        correctImageName: current.answerImageName,
                        score: gameState.score,
                        correctText: current.answer,
                        onNext: {
                            // ✅ 현재 문제는 항상 제거
                            quizItem.remove(at: currentIndex)
                            userAnswer = ""
                            showHint = false
                            showResult = false

                            if quizItem.isEmpty {
                                showFinalResult = true
                            } else if currentIndex >= quizItem.count {
                                currentIndex = 0
                            }
                        },
                        gameState: gameState
                    )
                }
            }

            .navigationDestination(isPresented: $showFinalResult) {
                ResultView(score: gameState.score)
            }

            .onAppear {
                if quizItem.isEmpty {
                switch selectedSubject {
                case "포켓몬": quizItem = pkmQuizList.shuffled()
                case "공룡": quizItem = dinoQuizList.shuffled()
                case "사물": quizItem = thingQuizList.shuffled()
                case "동물": quizItem = animalQuizList.shuffled()
                default: quizItem = pkmQuizList.shuffled()
                }
            }

            // ✅ 타이머는 최초 1회만 시작됨
            gameState.startTimer(duration: difficulty.timeLimit) {
                showFinalResult = true
            }
        }

            .onDisappear {
                timer?.invalidate()
            }
        }
    }

    // MARK: - 정답 제출 처리
    func handleAnswerSubmission(correctAnswer: String) {
        if userAnswer == correctAnswer {
            isCorrect = true
            gameState.score += difficulty.scorePerQuestion
        } else {
            isCorrect = false
            if gameState.life > 0 {
                gameState.life -= 1
            }
        }
        showResult = true
    }
}

// MARK: - Preview
#Preview {
    GamePlayView(
        gameState: GameState(),
        difficulty: .easy,
        selectedSubject: "동물"
    )
}
