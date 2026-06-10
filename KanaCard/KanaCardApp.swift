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
        .modelContainer(for: Kana.self) { result in
            switch result {
            case .success(let container):
                seedDatabase(container: container)
            case .failure(let error):
                print("Could not load Kana: \(error)")
            }
        }
    }
}

func seedDatabase(container: ModelContainer) {
    let context = ModelContext(container)
    
    // Checking if container already exists
    let descriptor = FetchDescriptor<Kana>()
    guard let count = try? context.fetchCount(descriptor), count == 0 else { return }
    
    for Kana in Kana.allExamples {
        context.insert(Kana)
    }
    
    // Save to the database
    do {
        try context.save()
    } catch {
        print("Failed to save Kana: \(error)")
    }
}
