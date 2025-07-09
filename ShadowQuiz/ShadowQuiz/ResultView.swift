//
//  SwiftUIView.swift
//
//
//  Created by jonghyuck on 7/7/25.
//

iimport SwiftUI
import SwiftData

struct ResultView: View {
    
    @Query var rankings: [Rank]
    @State private var nickName: String = ""
    @State private var score: Int = 0
    @State var subject: String
    @State private var navigateToRanking = false
    @Environment(\.modelContext) private var modelContext
    
    func insertRanking() {
        let newRanking = Rank(nickName: nickName, score: score, subject: subject)
        modelContext.insert(newRanking)
        do {
            try modelContext.save()
            print("Success to save: \(newRanking.nickName), \(newRanking.score), \(newRanking.subject)")
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    let backgroundColor: Color = Color(red: 203/255, green: 239/255, blue: 185/255)
    
    var body: some View {
        NavigationStack {
            ZStack{
                backgroundColor.ignoresSafeArea()
                VStack {
                    Text("결과 확인")
                        .padding()
                        .font(.system(size: 50, weight: .bold))
                        .fontDesign(.rounded)
                        .foregroundColor(Color.black.opacity(0.5))
                    
                    Text("당신의 최종 점수는")
                        .font(.system(size: 25, weight: .bold))
                        .fontDesign(.rounded)
                        .foregroundColor(Color.black.opacity(0.7))
                    
                    HStack {
                        Text("\(score)")
                            .font(.system(size: 150, weight: .bold))
                            .foregroundColor(Color.black)
                        
                        Text("점")
                            .font(.system(size: 30))
                            .foregroundColor(Color.black.opacity(0.4))
                    }
                    if score >= 150 {
                        Text("잘했어요!👍")
                            .font(.system(size: 40).bold())
                            .foregroundStyle(.gray)
                    } else if score >= 100 {
                        Text("좀 하는데요?!👏")
                            .font(.system(size: 40).bold())
                            .foregroundStyle(.gray)
                    } else if score == 0 {
                        Text("다시 해봐요!🙁")
                            .font(.system(size: 40).bold())
                            .foregroundStyle(.gray)
                    } else {
                        Text("평범하네요~😏")
                            .font(.system(size: 40).bold())
                            .foregroundStyle(.gray)
                            }
                    
                    Spacer()
                    Divider()
                    Spacer()
                    Spacer()
                    VStack {
                        Spacer()
                        Text("Upload your Score and Nickname🖋️")
                            .frame(width: 350, alignment: .leading)
                        TextField("Write your Nickname", text: $nickName)
                            .frame(width: 370)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        
                        Button {
                            insertRanking()
                            navigateToRanking = true
                        } label: {
                            Text("등록")
                                .font(.title3)
                                .frame(width: 70, height: 0)
                                .padding()
                                .background(Color.black.opacity(0.2))
                                .foregroundStyle(.white)
                                .cornerRadius(0)
                        }
                        VStack {
                            Rectangle()
                                .fill(Color.clear.opacity(0.2))
                                .frame(width: 0, height: 130)
                            NavigationLink(destination: MainView().navigationBarBackButtonHidden(true)) {
                                Rectangle()
                                    .fill(Color.black.opacity(0.2))
                                    .frame(width: 160, height: 50)
                                    .overlay(Text("홈으로")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 30)))
                            }
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 170, height: 0.5)
                            NavigationLink(destination: RankingView(selectedSubject: subject).navigationBarBackButtonHidden(true)) {
                                Rectangle()
                                    .fill(Color.black.opacity(0.2))
                                    .frame(width: 160, height: 50)
                                    .overlay(Text("랭킹보기")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 30)))
                            }
                            Spacer()
                        }
                    }
                }
                .navigationDestination(isPresented: $navigateToRanking) {
                    RankingView(selectedSubject: "포켓몬").navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    ResultView(subject: "포켓몬")
}

