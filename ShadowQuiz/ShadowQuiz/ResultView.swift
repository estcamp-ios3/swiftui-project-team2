//
//  SwiftUIView.swift
//
//
//  Created by jonghyuck on 7/7/25.
//

import SwiftUI
import SwiftData

struct ResultView: View {
    
    @Query var rankings: [Rank]
    @State private var nickName: String = ""
    @State var score: Int = 0
    @State var subject: String
    @State private var navigateToRanking = false
    @Environment(\.modelContext) private var modelContext
    
    
    var message: String {
        if score >= 150 {
            return "Great!👍"
        } else if score >= 100 {
            return "Good Job!👏"
        } else {
            return "Well Done😊"
        }
    }
    
    
    func insertRanking() {
        let newRanking = Rank(nickName: nickName, score: score, subject: subject)
        modelContext.insert(newRanking)
        do {
            try modelContext.save()
            print("Success to save: \(newRanking.nickName), \(newRanking.score)")
        } catch {
            print("Failed to save: \(error)")
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
                                .foregroundStyle(.gray)
                        }
                    }
                    Spacer()
                    Divider()
                    HStack {
                        Spacer()
                        NavigationLink(destination: MainView()) {
                            Rectangle()
                                .fill(Color.black.opacity(0.2))
                                .frame(width: 160, height: 50)
                                .overlay(Text("HOME")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 30)))
                        }
                        Spacer()
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 0.5, height: 60)
                        Spacer()
                        NavigationLink(destination: RankingView(selectedSubject: subject)) {
                            Rectangle()
                                .fill(Color.black.opacity(0.2))
                                .frame(width: 160, height: 50)
                                .overlay(Text("RANKING")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 30)))
                        }
                        Spacer()
                    }
                }
                VStack {
                    Spacer()
                    Text("Upload your Score and Nickname🖋️")
                        .frame(width: 350, alignment: .leading)
                    TextField("Write your Nickname", text: $nickName)
                        .frame(width: 370)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    Button {
                        insertRanking()
                        navigateToRanking = true
                    } label: {
                        Text("Upload")
                            .font(.title3)
                            .frame(width: 70, height: 0)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .foregroundStyle(.white)
                            .cornerRadius(0)
                    }
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $navigateToRanking) {
                RankingView(selectedSubject: "포켓몬")
            }
        }
    }
}


#Preview {
    ResultView(subject: "포켓몬")
}
