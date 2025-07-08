//
//  RankingView.swift
//  ShadowQuiz
//
//  Created by 권태우 on 7/7/25.
//

import SwiftUI

struct RankingView: View {
    let backgroundColor: Color = Color(red: 203/255, green: 239/255, blue: 185/255)
    
    @State private var selectedSubjectDefult: String = "Pokémon"
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack{
                Text("RANKING")
                    .foregroundStyle(Color.black.opacity(0.5))
                    .font(.largeTitle)
                    .padding()
                HStack(spacing: 0) {
                    ForEach(["Pokémon", "Dinosaur", "Animal", "Things"], id: \.self) { sub in
                        Button {
                            selectedSubjectDefult = sub
                        } label: {
                            Text(sub)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(
                                    selectedSubjectDefult == sub
                                    ? Color.white
                                    : Color.black.opacity(0.5)
                                )
                                .foregroundColor(
                                    selectedSubjectDefult == sub
                                    ? Color.black
                                    : Color.white
                                )
                        }
                    }
                }
                .padding(.horizontal, 16)

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
