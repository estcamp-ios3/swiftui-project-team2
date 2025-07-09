//
//  MainView.swift
//  ShadowQuiz
//
//  Created by 유재환 on 7/7/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @Query var rankings: [Rank]
    
    // SwiftData modelContext 가져오기
    //@Environment(\.modelContext) private var context
    
    @State var selectedLevelDefult: String = "하"
    @State var selectedSubjectDefult: String = "사물"
    @State var navigateToGame: Bool = false
    
    // 랭킹 인덱스
    @State private var scoreIndex: Int = 0
    
    // 랭킹 리스트
    var rankList: [String] {
        let top3 = rankings
            .sorted { $0.score > $1.score }
        
        let medals = ["🥇", "🥈", "🥉"]
        
        return top3.enumerated().map { index, rank in
            "\(medals[index]) \(rank.nickName) [\(rank.subject)] - \(rank.score)점"
        }
    }
    

    // 랭킹 슬라이드 3초마다 타이머
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
                    
                    // START 버튼
                    Button {
                        //saveGamePlay()
                        navigateToGame = true
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
                    NavigationLink {
                        RankingView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text(rankList[safe: scoreIndex] ?? "아직 등록된 랭킹이 없습니다")
                            .font(.system(size: 16, weight: .bold))
                            .fontDesign(.rounded)
                            .foregroundColor(Color.black.opacity(0.5))
                    }
                    .onReceive(timer) { _ in
                        withAnimation {
                            scoreIndex = (scoreIndex + 1) % max(rankList.count, 1)
                        }
                    }
                    
                    Spacer()
                }
                
                // 난이도,주제 데이터를 담아 view 이동
                .navigationDestination(isPresented: $navigateToGame) {
                    testGamePlayView(difficulty: selectedLevelDefult, selectedSubject: selectedSubjectDefult)
                }
                
            }

        }
    }
    
    // 굳이 저장할 필요없음.
//    func saveGamePlay() {
//        // 선택된 난이도, 주제 GamePlay 인스턴스 생성
//        let gameSet = GameSettings(level: selectedLevelDefult, topic: selectedSubjectDefult)
//        // 데이터 컨텍스트에 insert
//        context.insert(gameSet)
//    }
    
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}



#Preview {
    MainView()
}
