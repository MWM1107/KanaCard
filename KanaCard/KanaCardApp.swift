//
//  KanaCardApp.swift
//  KanaCard
//
//  Created by Kevin Struna on 12/31/25.
//

import SwiftUI
import SwiftData

@main
struct KanaCardApp: App {
    @AppStorage("appTheme") var appTheme: String = "Ocean"
    
    var body: some Scene {
        WindowGroup {
            KanaView()
                .tint(Color(appTheme))
        }
    }
}
