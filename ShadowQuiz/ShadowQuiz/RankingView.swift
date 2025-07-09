//
//  RankingView.swift
//  ShadowQuiz
//
//  Created by 권태우 on 7/7/25.
//

import SwiftUI
import SwiftData

struct RankingView: View {
    let backgroundColor: Color = Color(red: 203/255, green: 239/255, blue: 185/255)
    @State var numberOfRank: Int = 1
    
    @State private var selectedSubjectDefult: String = "Pokémon"
    
    var ranking: [Rank] = [
        Rank(nickName: "MIDKING", score: 300),
        Rank(nickName: "JUGKING", score: 80),
        Rank(nickName: "hide on bush", score: 200),
        Rank(nickName: "CJ CloudTempler", score: 180),
        Rank(nickName: "beamman", score: 100),
    ]
    
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
                        Text("RANK")
                        Text("Nickname")
                        Text("Score")
                    }
                    .padding()
                    
                    ForEach(ranking.sorted { $0.score > $1.score }, id: \.id) { rank in
                        GridRow{
                            Text("No. \(ranking.firstIndex(of: rank)! + 1)")
                            Text(rank.nickName)
                            Text("\(rank.score)")
                        }
                        .padding()
                        .background(Color.white)
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
