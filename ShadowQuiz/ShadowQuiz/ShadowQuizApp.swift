//
//  ShadowQuizApp.swift
//  ShadowQuiz
//
//  Created by 권태우 on 7/7/25.
//

import SwiftUI

@main
struct ShadowQuizApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Ranking.self)
    }
}
