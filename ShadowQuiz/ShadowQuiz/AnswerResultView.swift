//
//  AnswerResultView.swift
//  0707project
//
//  Created by dkkim on 7/7/25.
//

import SwiftUI

struct AnswerResultView: View {
    let score: Int  // 단순 값으로 전달 (바인딩 제거)
    let isCorrect: Bool
    let correctImageName: String
    let correctText: String
    let selectedLevelDefult: String
    let selectedSubjectDefult: String
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#CBEFB9")
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
                    
                    if isCorrect {
                        Text("점수: \(score)") // 점수 출력
                            .font(.title)
                    }
                    
                    Button("다음 문제") {
                        isPresented = true
                    }
                    .buttonStyle(.borderedProminent)
                    .navigationDestination(isPresented: $isPresented) {
                        GamePlayView(difficulty: selectedLevelDefult, selectedSubject: selectedSubjectDefult)
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
