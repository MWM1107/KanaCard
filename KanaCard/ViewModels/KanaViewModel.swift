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
    
    // MARK: - Properties
    var isSeion: Bool = true {
        didSet {
            if !isSeion && !isDakuon && !isHandakuon && !isYoon {
                isSeion = true
            }
            resetCurrentIndex()
        }
    }
    
    var isDakuon: Bool = true {
        didSet {
            if !isSeion && !isDakuon && !isHandakuon && !isYoon {
                isDakuon = true
            }
            resetCurrentIndex()
        }
    }
    
    var isHandakuon: Bool = false {
        didSet {
            if !isSeion && !isDakuon && !isHandakuon && !isYoon {
                isHandakuon = true
            }
            resetCurrentIndex()
        }
    }
    
    var isYoon: Bool = false {
        didSet {
            if !isSeion && !isDakuon && !isHandakuon && !isYoon {
                isYoon = true
            }
            resetCurrentIndex()
        }
    }
    
    var allKana: [Kana] = []
    var currentIndex: Int = 0
    var isFront: Bool = true
    
    var filter: KanaFilter = .all {
        didSet {
            resetCurrentIndex()
            isFront = true
        }
    }
    
    // MARK: - Initialization
    
    init(allKana: [Kana] = Kana.allExamples) {
        self.allKana = allKana
    }
    
    // MARK: - Computed Properties
    
    var filteredKana: [Kana] {
        var allowed: [KanaVariant] = []
        
        if isSeion {
            allowed.append(.seion)
        }
                
        if isDakuon {
            allowed.append(.dakuon)
        }
                
        if isHandakuon {
            allowed.append(.handakuon)
        }
            
        if isYoon {
            allowed.append(.yoon)
        }
                
        switch filter {
            case .hiragana:
                return allKana.filter { kana in
                    kana.type == .hiragana && allowed.contains(kana.variant)
                }
                    
            case .katakana:
                return allKana.filter { kana in
                    kana.type == .katakana && allowed.contains(kana.variant)
                }
                    
            case .all:
                return allKana
            }
        }
    
    var currentCard: Kana {
        filteredKana[currentIndex]
    }
    
    // MARK: - Methods / Intents
    
    func shuffleKanaCards() {
        allKana.shuffle()
    }
    
    func nextCard() {
        isFront = true
        currentIndex += 1
        if currentIndex >= filteredKana.count {
            resetCurrentIndex()
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
    
    func resetCurrentIndex() {
        currentIndex = 0
    }
}
