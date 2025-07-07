//
//  MainView.swift
//  ShadowQuiz
//
//  Created by 유재환 on 7/7/25.
//

import SwiftUI
import SwiftData


@Model
class Ranking {
    var nickname: String
    var score: Int

    init(nickname: String, score: Int) {
        self.nickname = nickname
        self.score = score
    }
}

struct MainView: View {

    @State private var selectedLevelDefult: String = "하"
    @State private var selectedSubjectDefult: String = "포켓몬"
    
    // 랭킹 인덱스
    @State private var scoreIndex: Int = 0
    
    // 랭킹 리스트
    let rankList = [
        "🥇 1위[닉네임] - 159점",
        "🥈 2위[닉네임] - 140점",
        "🥉 3위[닉네임] - 120점"
    ]

    // 3초마다 타이머
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // 배경 색상
    let backgroundColor: Color = Color(red: 203/255, green: 239/255, blue: 185/255)
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 40) {
                    
                    Spacer()
                    
                    Text("Shadow Quiz")
                        .font(.system(size: 54, weight: .bold))
                        .fontDesign(.rounded)
                        .foregroundColor(Color.black.opacity(0.5))
                    
                    Spacer()
                    
                    // 난이도 선택 버튼
                    HStack(spacing: 0) {
                        ForEach(["상", "중", "하"], id: \.self) { level in
                            Button {
                                selectedLevelDefult = level
                            } label: {
                                Text(level)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .background(
                                        selectedLevelDefult == level
                                        ? Color.white
                                        : Color.black.opacity(0.5)
                                    )
                                    .foregroundColor(
                                        selectedLevelDefult == level
                                        ? Color.black
                                        : Color.white
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    // 주제 선택 버튼
                    HStack(spacing: 0) {
                        ForEach(["사물", "포켓몬", "공룡", "동물"], id: \.self) { sub in
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
                    
                    Spacer()
                    
                    Button {
                        print("Start!")
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 200, height: 200)
                                .shadow(radius: 5)
                            
                            VStack(spacing: 10) {
                                Text("START")
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .bold()
                                
                                Image(systemName: "play.fill")
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .font(.largeTitle)
                            }
                        }
                        .padding(0)
                    }
                    
                    Spacer()
                    
                    // 슬라이드 랭킹
                    Text(rankList[scoreIndex])
                        .font(.system(size: 28, weight: .bold))
                        .fontDesign(.rounded)
                        .foregroundColor(Color.black.opacity(0.5))
                        .onReceive(timer) { _ in
                            withAnimation {
                                scoreIndex = (scoreIndex + 1) % rankList.count
                            }
                        }
                    
                    Spacer()
                    
                }
                
            }
        }
    }

}

#Preview {
    MainView()
}
