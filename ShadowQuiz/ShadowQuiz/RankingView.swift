//
//  RankingView.swift
//  ShadowQuiz
//
//  Created by 권태우 on 7/7/25.
//

import SwiftUI

struct RankingView: View {
    let backgroundColor: Color = Color(red: 203/255, green: 239/255, blue: 185/255)
    
    @State var isPokemonSelected: Bool = true
    @State var isDinoSelected: Bool = false
    @State var isAnimalsSelected: Bool = false
    
    @State var selectedTextColor: Color = Color.black
    @State var selectedBgColor: Color = Color.white
    @State var unselectedTextColor: Color = Color.white
    @State var unselectedBgColor: Color = Color.black.opacity(0.5)
    
    func btnPokemonPressed(){
        isPokemonSelected = true
        isDinoSelected = false
        isAnimalsSelected = false
        
    }
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack{
                Text("RANKING")
                    .foregroundStyle(Color.black.opacity(0.5))
                    .font(.largeTitle)
                    .padding()
                HStack{
                    Button("Pokémon"){
                        btnPokemonPressed()
                    }
                    .foregroundStyle(selectedTextColor)
                    .frame(width: 100, height: 50)
                    .background(selectedBgColor)
                    Button("Dinosaurs"){
                        isPokemonSelected = false
                        isDinoSelected = true
                        isAnimalsSelected = false
                    }
                    .foregroundStyle(unselectedTextColor)
                    .frame(width: 100, height: 50)
                    .background(unselectedBgColor)
                    Button("Animals"){
                        isPokemonSelected = false
                        isDinoSelected = false
                        isAnimalsSelected = true
                    }
                    .foregroundStyle(unselectedTextColor)
                    .frame(width: 100, height: 50)
                    .background(unselectedBgColor)
                }
                Grid{
                    GridRow{
                        Text("Rank")
                        Text("Nickname")
                        Text("Score")
                    }
                    .padding()
                    
                    GridRow{
                        Text("🥇")
                        Text("MIDKING")
                        Text("300")
                    }
                    GridRow{
                        Text("🥈")
                        Text("JUGKING")
                        Text("270")
                    }
                    GridRow{
                        Text("🥉")
                        Text("hide on bush")
                        Text("200")
                    }
                    GridRow{
                        Text("4")
                        Text("CJ CloudTempler")
                        Text("180")
                    }
                    GridRow{
                        Text("5")
                        Text("beamman")
                        Text("100")
                    }
                }
                Text("If you want to leave your name, be stronger.")
                    .padding()
                Button("Home"){
                    
                }
                .foregroundStyle(.white)
                .frame(width: 200, height: 50)
                .background(Color.black.opacity(0.5))
            }
        }
    }
}

#Preview {
    RankingView()
}
