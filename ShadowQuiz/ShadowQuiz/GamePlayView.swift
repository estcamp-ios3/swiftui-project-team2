//
//  GamePlayView.swift
//  0707project
//
//  Created by dkkim on 7/7/25.
//

import SwiftUI



struct GamePlayView: View {
    let questionImageName: String
    let correctAnswer: String
    let hint: String

    
    @State private var quizItemPKM = quizList.shuffled()
    @State private var currentIndex = 0
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var showHint = false

    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#CBEFB9").opacity(0.5)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("누구의 실루엣일까요?")
                        .font(.title)
                        .bold()

                    Image("pkmshadow01")
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
                            isCorrect = false
                            showResult = true
                        }
                        .buttonStyle(.bordered)

                        Button("정답 제출") {
                            isCorrect = (userAnswer == correctAnswer)
                            showResult = true
                        }
                        .buttonStyle(.borderedProminent)
                    }

                    if showHint {
                        Text("힌트: \(hint)")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $showResult) {
                AnswerResultView(
                    isCorrect: isCorrect,
                    correctImageName: correctAnswer,
                    correctText: correctAnswer
                )
            }
        }
    }
}

#Preview {
    let previewList = Array(quizList.shuffled().prefix(1))

    Group {
        ForEach(previewList, id: \.id) { item in
            GamePlayView(
                questionImageName: item.imageName,
                correctAnswer: item.answer,
                hint: item.hint
            )
        }
    }
}
