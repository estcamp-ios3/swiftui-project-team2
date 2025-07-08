//
//  ContentView.swift
//  ShadowQuiz
//
//  Created by 권태우 on 7/7/25.
//

import SwiftUI


struct ContentView: View {
    var backGroundColor: Color = Color(red: 203/255, green: 239/255, blue: 185/255)
    var body: some View {
        NavigationStack {
            ZStack {
                backGroundColor.ignoresSafeArea()
                VStack {
                    Image(systemName: "gamecontroller.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    NavigationLink(destination: ResultView(score: 0)) {
                        Text("Join this Game!")
                            .font(.system(size: 50))
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
