//
//  SwiftUIView.swift
//
//
//  Created by jonghyuck on 7/7/25.
//

import SwiftUI
import SwiftData

struct ResultView: View {

    @State private var nickName: String = ""
    @State private var score: Int = 0
    
    var message: String {
        if score >= 150 {
            return "Great!👍"
        } else if score >= 100 {
            return "Good Job!👏"
        } else {
            return "Well Done😊"
        }
    }
    
    @Model
    class Result {
        var userId: UUID
        var score: Int
//        var
        init(id: UUID, score: Int) {
            self.userId = id
            self.score = score
        }
    }

    
    
    
    let backgroundColor: Color = Color(red: 203/255, green: 239/255, blue: 185/255)
    
    var body: some View {
        NavigationStack {
            ZStack{
                backgroundColor.ignoresSafeArea()
                VStack {
                    Text("GAME RESULT")
                        .padding()
                        .font(.system(size: 50, weight: .bold))
                        .fontDesign(.rounded)
                        .foregroundColor(Color.black.opacity(0.5))
                    
                    Text("Your Total Score is")
                        .font(.system(size: 25, weight: .bold))
                        .fontDesign(.rounded)
                        .foregroundColor(Color.black.opacity(0.7))
                    
                    Text("\(score)")
                        .font(.system(size: 100, weight: .bold))
                        .fontDesign(.rounded)
                        .foregroundColor(Color.black)
                    
                    if score >= 100 {
                        Text(message)
                            .font(.system(size: 45).bold())
                    } else if score < 100 {
                        NavigationLink(destination: MainView()) {
                            Text("Try again🙁")
                                .font(.system(size: 45).bold())
                        }
                    }
                        Divider()
                    
//                    TextField("Write your Nickname", text: $nickName)
//                        .textFieldStyle(.roundedBorder)
//                        .padding(.horizontal)
//                    NavigationLink(destination: MainView()) {
//                        Text("Upload")
//                    }
                    
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(destination: MainView()) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.black.opacity(0.2))
                                    .frame(width: 150, height: 100)
                                    .overlay(Text("Go to HOME")
                                        .font(.largeTitle))
                            }
                            Spacer()
                            Rectangle()
                                .frame(width: 1, height: 100)
                            Spacer()
                            NavigationLink(destination: RankingView()) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.black.opacity(0.2))
                                    .frame(width: 150, height: 100)
                                    .overlay(Text("Check the\nRANKING")
                                        .font(.largeTitle))
                        }
                        Spacer()
                    }
                }
                VStack {
                    TextField("Write your Nickname", text: $nickName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    NavigationLink(destination: RankingView()) {
                        Text("Upload")
                    }
                }
            }
        }
    }
}
#Preview {
    ResultView()
}
