//
//  SwiftUIView.swift
//
//
//  Created by jonghyuck on 7/7/25.
//

import SwiftUI
import SwiftData

struct ResultView: View {
    
    @Query var rankings: [Ranking]
    @State private var nickName: String = ""
    @State private var score: Int = 0
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
        let newRanking = Ranking(nickName: nickName, score: score)
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
                                .frame(width: 150, height: 50)
                                .overlay(Text("HOME")
                                    .foregroundStyle(.white)
                                    .font(.largeTitle))
                        }
                        Spacer()
                        Rectangle()
                            .frame(width: 1, height: 50)
                        Spacer()
                        NavigationLink(destination: RankingView()) {
                            Rectangle()
                                .fill(Color.black.opacity(0.2))
                                .frame(width: 150, height: 50)
                                .overlay(Text("RANKING")
                                    .foregroundStyle(.white)
                                    .font(.largeTitle))
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
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .foregroundStyle(.white)
                            .cornerRadius(0)
                    }
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $navigateToRanking) {
                RankingView()
            }
        }
    }
}


#Preview {
    ResultView()
}
