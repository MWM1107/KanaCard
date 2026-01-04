//
//  KanaViewModel.swift
//  KanaCard
//
//  Created by Kevin Struna on 12/31/25.
//

import Foundation
import SwiftUI
import SwiftData

enum KanaFilter {
    case hiragana, katakana, all
}

@Observable
class KanaViewModel {
    var allKana: [Kana] = []
    var currentIndex: Int = 0
    var isFront: Bool = true
    var filter: KanaFilter = .all {
        didSet {
            currentIndex = 0
            isFront = true
        }
    }

    init(allKana: [Kana] = Kana.allExamples) {
        self.allKana = allKana
    }
    
    var filteredKana: [Kana] {
        switch filter {
        case .hiragana:
            return allKana.filter {$0.type == .hiragana}
        case .katakana:
            return allKana.filter {$0.type == .katakana}
        case .all:
            return allKana
        }
    }
    
    var currentCard: Kana {
            filteredKana[currentIndex]
    }
        
    func shuffleKanaCards() {
        allKana.shuffle()
    }
    
    func nextCard() {
        isFront = true
        currentIndex += 1
        if currentIndex >= filteredKana.count {
            currentIndex = 0
        }
    }
    
    func previousCard() {
        isFront = true
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = filteredKana.count - 1
        }
    }
    
    func flipCard() {
        isFront.toggle()
    }
    
}
