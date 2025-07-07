//
//  SwiftUIView.swift
//  
//
//  Created by jonghyuck on 7/7/25.
//

import SwiftUI


struct ResultView: View {
    //    @State var resultData: resultData = resultData()
    //    func resultScore() {
    //        level * question
    //    }
    enum Difficulty {
        case easy, hard, veryHard
    }
    
    struct Question {
        let id: Int
        let text: String
        var difficulty: Difficulty
        let answer: String
    }
    
    //    func resultScore(correctAnswer: String, userAnswer: String) -> Int {
    //        let question = getQuestion() // 퀴즈 문제 가져오기
    //
    //        if question.difficulty == .easy {
    //            return 10
    //        } else if question.difficulty == .hard {
    //            return 20
    //        } else if question.difficulty == .veryHard {
    //        return 30
    //        } else {
    //            return 0
    //        }
    //    }
    
    let score: Int
    
    var message: String {
        if score >= 200 {
            return "Great!👍"
        } else if score >= 100 {
            return "Good Job!👏"
        } else if score == 0 {
            return "Try Again🙁"
        } else {
            return "Well Done😊"
        }
    }
    
    
  var backGroundColor: Color = Color(red: 203/255, green: 239/255, blue: 185/255)
    
    
    var body: some View {
        NavigationStack {
            ZStack{
            backGroundColor.ignoresSafeArea()
                VStack {
                    Text("GAME RESULT")
                        .padding()
                        .font(.largeTitle.bold())

                    Text("Your Total Score is")
                        .font(.system(size: 25))
                    HStack {
                        // Text(resultScore(correctAnswer: <#T##String#>, userAnswer: <#T##String#>)
                        //  점순데, 쉬움 10점씩, 어려움 20점씩, 개어려움 30점씩
                        //                        .font(.title)
                        //                        .padding()
                        Text("200")
                            .font(.system(size:100).bold())
                            .shadow(color:.teal, radius: 5)
                        Text("점")
                            .font(.title)
                    }
                    Spacer()
                    Text(message)
                        .font(.system(size: 50).bold())

                    Spacer()
//                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: MainView()) {
                            RoundedRectangle(cornerRadius: 20) // 둥근 모서리 뷰
                                .fill(Color.black.opacity(0.2)) // 둥근 모서리 뷰의 색상 설정
                                .frame(width: 150, height: 100) // 둥근 모서리 뷰의 크기 설정
                                .offset(x: 0, y: 0) // 텍스트 뒤에 위치하도록 위치 조정
                                .overlay(Text("Go to HOME")
                                    .font(.largeTitle))
                        }
                        Spacer()
                        Rectangle()
                            .frame(width: 1, height: 100)
                        Spacer()
                        NavigationLink(destination: RankingView()) {
                            RoundedRectangle(cornerRadius: 20) // 둥근 모서리 뷰
                             .fill(Color.black.opacity(0.2)) // 둥근 모서리 뷰의 색상 설정
                             .frame(width: 150, height: 100) // 둥근 모서리 뷰의 크기 설정
                             .offset(x: 0, y: 0) // 텍스트 뒤에 위치하도록 위치 조정
                             .overlay(Text("Check the\nRANKING")
                                .font(.largeTitle))
                            }
                        Spacer()
                    }
                }
            }

        }
    }
}
#Preview {
    ResultView(score: 200)
}
