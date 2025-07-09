//
//  testGamePlayView.swift
//  ShadowQuiz
//
//  Created by dkkim on 7/9/25.
//


import SwiftUI
import Foundation
import Combine

//01. 화면 구조와 입력값
struct testGamePlayView: View {
    let difficulty: String
    let selectedSubject: String

    //02. 주요 상태 변수
    @State private var quizItem: [QuizItem] = []
    @State private var currentIndex = 0
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var showHint = false
    @State private var showFinalResult = false
    @State private var timer: Timer?
    @State private var score: Int = 0
    @State var life: Int = 3

    //03-1. 난이도에 따른 시간 설정
    var timeLimit: Int {
        switch difficulty {
        case "하": return 180
        case "중": return 120
        case "상": return 60
        default: return 0
        }
    }

    //03-2. 난이도에 따른 점수 설정
    var scorePerQuestion: Int {
        switch difficulty {
        case "하": return 10
        case "중": return 20
        case "상": return 30
        default: return 0
        }
    }

    //04. 하트 표시용 문자열 변수
    @State var heart: String = "❤️"
    @State var brokenHeart: String = "💔"
    @State var lives: String = "❤️❤️❤️"

    @State var timeRemaining: Int = 0
    @State var timerStarted = false

    //05. 타이머 함수
    func startTimer(duration: Int, onTimeUp: @escaping () -> Void) {
        guard !timerStarted else { return }
        timeRemaining = duration
        timerStarted = true

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            DispatchQueue.main.async {
                self.timeRemaining -= 1
                if self.timeRemaining <= 0 {
                    self.timer?.invalidate()
                    self.timerStarted = false
                    onTimeUp()
                }
            }
        }
    }

    //06. 정답 제출 함수
    func handleAnswerSubmission(correctAnswer: String) {
        if userAnswer == correctAnswer {
            isCorrect = true
            score += scorePerQuestion
        } else {
            isCorrect = false
            if life > 0 {
                life -= 1
            }
        }

        if life <= 0 {
            showFinalResult = true
        }

        switch life {
        case 1:
            lives = heart + brokenHeart + brokenHeart
        case 2:
            lives = heart + heart + brokenHeart
        case 0:
            lives = brokenHeart + brokenHeart + brokenHeart
            showFinalResult = true
        default:
            lives = heart + heart + heart
        }
        showResult = true
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerStarted = false
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#CBEFB9").ignoresSafeArea()

                // 조건 분기 로직
                // showResult=true ->
                if showResult {
                    if currentIndex < quizItem.count {
                        AnswerResultView(
                            //정답 결과 화면으로 이동
                            score: score, //현재 누적점수
                            isCorrect: isCorrect, // 답이 맞았나 틀렸나
                            correctImageName: quizItem[currentIndex].answerImageName,//정답 이미지
                            correctText: quizItem[currentIndex].answer, //정답 텍스트
                            selectedLevelDefult: difficulty, //선택한 난이도
                            selectedSubjectDefult: selectedSubject, //선택한 주제
                            onNext: { //"다음 문제" 버튼 누를때 실행할 로직
                                showResult = false
                                if currentIndex + 1 < quizItem.count {
                                    currentIndex += 1
                                } else {
                                    showFinalResult = true
                                }
                                userAnswer = ""
                                showHint = false
                            },
                            onFinish: { // " 게임종료" 버튼을 누를때 실행할 로직
                                showResult = false
                                showFinalResult = true
                            }
                        )
                    }
                } else if currentIndex < quizItem.count {
                    let current = quizItem[currentIndex]
                    ScrollView {
                        VStack(spacing: 30) {
                            HStack {
                                Text("⏱ 남은 시간: \(timeRemaining)초").bold()
                                Spacer()
                                Text("LIFE:")
                                Text(lives)
                            }
                            Text("점수: \(score)").font(.title).bold()
                            Text("무엇 일까요?").font(.title)
                            Image(current.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                            TextField("정답을 입력하세요", text: $userAnswer)
                                .font(.system(size: 40))
                                .textFieldStyle(.roundedBorder)
                                .frame(height: 10)
                                .padding(.horizontal, 20)
                            HStack(spacing: 15) {
                                Button("힌트") {
                                    showHint.toggle()
                                }.buttonStyle(.bordered)
                                Button("패스") {
                                    let skipped = quizItem.remove(at: currentIndex)
                                    quizItem.append(skipped)
                                    if currentIndex >= quizItem.count {
                                        currentIndex = 0
                                    }
                                    userAnswer = ""
                                    showHint = false
                                }.buttonStyle(.bordered)
                                Button("정답 제출") {
                                    handleAnswerSubmission(correctAnswer: current.answer)
                                }.buttonStyle(.borderedProminent)
                            }
                            Button("게임종료") {
                                showFinalResult = true
                            }.buttonStyle(.bordered)
                            if showHint {
                                Text("힌트: \(current.hint)").foregroundColor(.blue)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationDestination(isPresented: $showFinalResult) {
                ResultView(score: score, subject: selectedSubject)
            }
        }
        // onAppear는 뷰가 화면에 처음 보일때 실행되는 코드다.
        // 아래 코드는 퀴즈 데이터를 주제별로 가져옴. 그리고 타이머 시작
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
            if !timerStarted {
                startTimer(duration: timeLimit) {
                    showFinalResult = true
                }
            }
        }
        // onDisappear는 뷰가 화면에 사라질때 실행되는 코드다.
        .onDisappear {
            timer?.invalidate()
        }
        .navigationBarBackButtonHidden(true)
    }
}


// MARK: - Preview
#Preview {
    testGamePlayView(difficulty: "하", selectedSubject: "동물")
}
