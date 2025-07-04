//
//  ContentView.swift
//  swiftUIProject
//
//  Created by 권태우 on 7/4/25.
//
//  2조 프로토타입 ^^

import SwiftUI

struct ContentView: View {
    @State var level: Int = 0
    
    var body: some View {
        NavigationStack {
            Text("심심하신가요?\n그렇다면 불러주세요")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Shadow QUIZ")
            Text("Level")
            HStack {
                Button("Easy"){
                    level = 0
                }
                Button("Hard"){
                    level = 1
                }
                Button("HELL"){
                    level = 2
                }
            }
            Text("Topic")
            HStack {
                Button("Pokémon"){
                    level = 0
                }
                Button("Animals"){
                    level = 1
                }
                Button("Dinosaurs"){
                    level = 2
                }
                Button("Things"){
                    level = 2
                }
            }
            NavigationLink(destination: GameView(level: level)) {
                Text("Game Start")
            }
            Text("The highest score is 10 by someone.")
        }
        .padding()
    }
}

struct GameView: View {
    let level: Int
    @State var answer: String = ""
    @State var hint: String = ""
    @State var chance: Int = 3
    
    @State var heart: String = "❤️"
    @State var brokenHeart: String = "💔"
    @State var lives: String = "❤️❤️❤️"
    
    @State var isCorrect: Bool = false
    
    var body: some View {
        NavigationStack{
            Text("치킨 좀 먹고 왔습니다")
                .font(.largeTitle)
                .foregroundStyle(.red)
            Text("You can get \(10+level) points per a correct answer.")
            Image("quiz")
            Text("\(hint)")
            TextField("", text: $answer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Button("Check"){
                    if answer == "pikachu"{
                        isCorrect = true
                    } else{
                        chance -= 1
                        switch chance{
                        case 1:
                            lives = heart + brokenHeart + brokenHeart
                        case 2:
                            lives = heart + heart + brokenHeart
                        default:
                            lives = brokenHeart + brokenHeart + brokenHeart
                        }
                    }
                    
                }
                .navigationDestination(isPresented: $isCorrect){
                    ResultView()
                }
                Button("Pass"){
                    
                }
            }
            Button("Show Hint"){
                hint = "No Hint ^^"
            }
            Button("Finish the quiz"){
                
            }
            Text(lives)
        }
    }
}

struct ResultView: View {
    let teamMates: [String] = ["권태우", "김동우", "유재환", "임종혁"]
    @State var teamLeader: String = ""
    
    var body: some View {
        NavigationStack{
            Text("조장은 \(teamLeader) ㅊㅊ")
            Button("드가자잇"){
                teamLeader = teamMates.randomElement() ?? "Try Again"
            }
        }
    }
}

#Preview {
    //    ContentView()
    GameView(level: 1)
}
