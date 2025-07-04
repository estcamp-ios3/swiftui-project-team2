//
//  ContentView.swift
//  swiftUIProject
//
//  Created by 권태우 on 7/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var level: Int = 0
    
    var body: some View {
        NavigationStack {
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
    
    var body: some View {
        VStack{
            Text("You can get \(10+level) points per a correct answer.")
            Image("quiz")
            Text("\(hint)")
            TextField("", text: $answer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack{
                Button("Check"){
                    
                }
                Button("Pass"){
                    
                }
            }
            Button("Show Hint"){
                hint = "No Hint ^^"
            }
            Button("Finish the quiz"){
                
            }
        }
    }
}

#Preview {
    ContentView()
}
