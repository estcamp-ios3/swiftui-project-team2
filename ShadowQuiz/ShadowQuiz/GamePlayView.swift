//
//  GamePlayView.swift
//  0707project
//
//  Created by dkkim on 7/7/25.
//

import SwiftUI

// MARK: - 난이도 설정
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

// MARK: - 게임 플레이 화면
struct GamePlayView: View {
    // @Binding var path: NavigationPath 추후 mainview에 아래와같은 코드 입력한 뒤, 포기하기 버튼 코드 활성화하기.
        //    @State private var navPath = NavigationPath()
        //
        //    NavigationStack(path: $navPath) {
        //        // START 버튼을 눌렀을 때
        //        Button {
        //            navPath.append("play")
        //        } label: {
        //            Text("START")
        //        }
        //        .navigationDestination(for: String.self) { value in
        //            if value == "play" {
        //                GamePlayView(path: $navPath, ...)
        //            }
        //        }
        //    }
    
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
            if currentIndex < quizItem.count {
                let current = quizItem[currentIndex]

                ZStack {
                    Color(hex: "#CBEFB9").opacity(0.5).ignoresSafeArea()

                    VStack(spacing: 30) {
                        // 상단: 타이머, 점수, 라이프
                        HStack {
                            Text("⏱ 남은 시간: \(gameState.timeRemaining)초")
                                .font(.caption).bold()
                            Spacer()
                            Text("점수: \(gameState.score)")
                                .font(.caption)
                            Text("LIFE:")
                                .bold()
                            ForEach(0..<gameState.life, id: \.self) { _ in
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
                            Button("힌트") {
                                showHint.toggle()
                            }
                            .buttonStyle(.bordered)

                            Button("패스") {
                                let skipped = quizItem[currentIndex]

                                   // 현재 문제 제거 후 뒤로 추가
                                   quizItem.remove(at: currentIndex)
                                   quizItem.append(skipped)

                                   // currentIndex는 그대로 두거나, 안전하게 다시 0으로 초기화
                                   currentIndex = 0

                                   // UI 초기화
                                   userAnswer = ""
                                   showHint = false
                                   showResult = false
                                
                            }
                            .buttonStyle(.bordered)

                            Button("정답 제출") {
                                handleAnswerSubmission(currentAnswer: current.answer)
                            }
                            .buttonStyle(.borderedProminent)

                            Button("포기하기") {
                               // path.removeLast(path.count)
                            }
                            .foregroundColor(.red)
                        }

                        if showHint {
                            Text("힌트: \(current.hint)")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                }
                // 결과 화면으로 이동 10문제 다 풀었을 경우 안넘어가는 오류가 있음
                .navigationDestination(isPresented: $showResult) {
                    AnswerResultView(
                        isCorrect: isCorrect,
                        correctImageName: current.answerImageName,
                        score: gameState.score,
                        correctText: current.answer,
                        onNext: {
                            if currentIndex + 1 >= quizItem.count {
                                showResult = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    showFinalResult = true
                                }
                            } else {
                                currentIndex += 1
                                userAnswer = ""
                                showHint = false
                                showResult = false
                            }
                        },
                        gameState: gameState
                    )
                }
            }
        }
        .navigationDestination(isPresented: $showFinalResult) {
            ResultView(score: gameState.score)
        }
        .onAppear {
            gameState.timeRemaining = difficulty.timeLimit

            // 주제에 따라 문제 선택
            switch selectedSubject {
            case "포켓몬":
                quizItem = pkmQuizList.shuffled()
            case "공룡":
                quizItem = dinoQuizList.shuffled()
            case "사물":
                quizItem = thingQuizList.shuffled()
            default:
                quizItem = pkmQuizList.shuffled()
            }

            // 타이머 시작
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if gameState.timeRemaining > 0 {
                    gameState.timeRemaining -= 1
                } else {
                    timer?.invalidate()
                    showFinalResult = true
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    // MARK: - 정답 처리 로직
    func handleAnswerSubmission(currentAnswer: String) {
        if userAnswer == currentAnswer {
            isCorrect = true
            gameState.score += difficulty.scorePerQuestion
        } else {
            isCorrect = false
            if gameState.life > 0 {
                gameState.life -= 1
            }
            if gameState.life == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFinalResult = true
                }
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
        selectedSubject: "사물"
    )
}
