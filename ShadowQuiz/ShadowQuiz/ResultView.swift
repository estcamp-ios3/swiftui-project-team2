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
            print("Succese to save: \(newRanking.nickName), \(newRanking.score)")
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
                        }
                    }
                    Divider()
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
                    
                    Button {
                        insertRanking()
                        navigateToRanking = true
                    } label: {
                        Text("Upload")
                            .font(.title2)
                            .padding()
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(10)
                    }
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
