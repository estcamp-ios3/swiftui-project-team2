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
    
    @State var selectedSubject: String
    
    @Query var rankings: [Rank]
    var sortedRankings: [Rank] {
        rankings.sorted { $0.score > $1.score }
    }
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack{
                Text("RANKING")
                    .bold(true)
                    .foregroundStyle(Color.black.opacity(0.5))
                    .font(.largeTitle)
                    .padding()
                HStack(spacing: 0) {
                    ForEach(["포켓몬", "공룡", "동물", "사물"], id: \.self) { sub in
                        Button {
                            selectedSubject = sub
                        } label: {
                            Text(sub)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(
                                    selectedSubject == sub
                                    ? Color.white
                                    : Color.black.opacity(0.5)
                                )
                                .foregroundColor(
                                    selectedSubject == sub
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
                    
                    ForEach(sortedRankings, id: \.id) { rank in
                        GridRow{
                            Text(
                                sortedRankings.firstIndex(of: rank)! == 0
                                ? "🥇"
                                : "\(sortedRankings.firstIndex(of: rank)! + 1)"
                            )
                            Text(rank.nickName)
                            Text("\(rank.score)")
                        }
                        .font(.title)
                        Divider()
                            .padding(.horizontal)
                    }
                }
                .bold(true)
                .background(Color.white.opacity(0.5))
                
                Text("If you want to leave your name here,\nBE STRONGER.")
                    .multilineTextAlignment(.center)
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
    RankingView(selectedSubject: "포켓몬")
}
