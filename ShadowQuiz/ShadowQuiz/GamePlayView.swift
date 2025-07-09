//
//  GamePlayView.swift
//  0707project
//
//  Created by dkkim on 7/7/25.
//

import SwiftUI
import Foundation
import Combine

// MARK: - GamePlayView
struct GamePlayView: View {
    let difficulty: String
    let selectedSubject: String
    
    @State private var quizItem: [QuizItem] = []
    @State private var currentIndex = 0
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var showHint = false
    @State private var showFinalResult = false
    @State private var timer: Timer?
    @State var score: Int = 0
    @State var life: Int = 3
    
    var timeLimit: Int {
        switch difficulty {
        case "하": return 180
        case "중": return 120
        case "상": return 60
        default: return 0
        }
    }
    
    var scorePerQuestion: Int {
        switch difficulty {
        case "하": return 10
        case "중": return 20
        case "상": return 30
        default: return 0
        }
    }
    
    @State var heart: String = "❤️"
    @State var brokenHeart: String = "💔"
    @State var lives: String = "❤️❤️❤️"
    
    @State var timeRemaining: Int = 0
    @State var timerStarted = false // ✅ 중복 방지용
    
    func startTimer(duration: Int, onTimeUp: @escaping () -> Void) {
        guard !timerStarted else { return } // ✅ 이미 시작했다면 무시
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
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerStarted = false
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#CBEFB9").ignoresSafeArea()
                
                if currentIndex < quizItem.count {
                    let current = quizItem[currentIndex]
                    
                    ScrollView {
                        VStack(spacing: 30) {
                            HStack {
                                Text("⏱ 남은 시간: \(timeLimit)초")
                                    .bold()
                                Spacer()
                                Text("LIFE:")
                                Text(lives)
                            }
                            Text("점수: \(score)")
                                .font(.title).bold()
                            Text("무엇 일까요?")
                                .font(.title)
                            
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
                            
                            Button("끗"){
                                showFinalResult = true
                            }
                            
                            if showHint {
                                Text("힌트: \(current.hint)")
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
                        score: score,
                        correctText: current.answer,
                        selectedLevelDefult: difficulty,
                        selectedSubjectDefult: selectedSubject
                    )
                }
            }
            
            .navigationDestination(isPresented: $showFinalResult) {
                ResultView(subject: selectedSubject)
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
                startTimer(duration: timeLimit) {
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
            score += scorePerQuestion
        } else {
            isCorrect = false
            if life > 0 {
                life -= 1
            }
        }
        switch life{
        case 1:
            lives = heart + brokenHeart + brokenHeart
        case 2:
            lives = heart + heart + brokenHeart
        case 0 :
            showFinalResult = true
        default:
            lives = heart + heart + heart
        }
        showResult = true
    }
}

// MARK: - Preview
#Preview {
    GamePlayView(difficulty: "상", selectedSubject: "동물")
}
