//
//  RankingView.swift
//  ShadowQuiz
//
//  Created by 권태우 on 7/7/25.
//

import SwiftUI

struct RankingView: View {
    var body: some View {
        Text("RANKING")
            .font(.largeTitle)
            .padding()
        Grid{
            GridRow{
                Text("Rank")
                Text("Nickname")
                Text("Score")
            }
            .padding()
            
            GridRow{
                Text("1")
                Text("MIDKING")
                Text("300")
            }
            GridRow{
                Text("2")
                Text("JUGKING")
                Text("270")
            }
            GridRow{
                Text("3")
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

#Preview {
    RankingView()
}
