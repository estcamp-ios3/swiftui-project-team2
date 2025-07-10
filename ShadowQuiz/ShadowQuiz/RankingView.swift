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
    @State var goHome: Bool = false
    
    @Query var rankings: [Rank]
    var sortedRankings: [Rank] {
        rankings.sorted { $0.score > $1.score}
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                VStack{
                    Text("랭    킹")
                        .bold(true)
                        .foregroundStyle(Color.black.opacity(0.5))
                        .font(.largeTitle)
                        .padding()
                    
                    Grid{
                        GridRow{
                            VStack {
                                Text("순위")
                                Text("(주제)").font(.caption)
                            }
                            Text("닉네임")
                            Text("점수")
                        }
                        .padding()
                        
                        ForEach(sortedRankings.prefix(5), id: \.id) { rank in
                            GridRow{
                                VStack{
                                    Text(
                                        sortedRankings.firstIndex(of: rank)! == 0
                                        ? "🥇"
                                        : "\(sortedRankings.firstIndex(of: rank)! + 1)위"
                                    )
                                    Text("(\(rank.subject))").font(.caption)
                                }
                                Text(rank.nickName).font(.title)
                                Text("\(rank.score)").font(.title)
                            }
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                    .bold(true)
                    .background(Color.white.opacity(0.5))
                    
                    VStack {
                        Text("순위는 5위까지만 나타납니다. 이름을 남기시려면")
                        Text("더 강해지세요.").bold(true)
                    }
                    .padding()
                    NavigationLink(destination: MainView().navigationBarBackButtonHidden(true)){
                        Text("홈으로")
                    }
                    .foregroundStyle(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.black.opacity(0.5))
                }
            }
        }
    }
}


#Preview {
    RankingView()
}
