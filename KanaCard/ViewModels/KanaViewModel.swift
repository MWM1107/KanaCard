//
//  KanaViewModel.swift
//  KanaCard
//
//  Created by Kevin Struna on 12/31/25.
//

import Foundation
import SwiftData
import SwiftUI


enum KanaFilter {
    case hiragana, katakana, all
}

@Observable
@MainActor
class KanaViewModel {
    
    // MARK: - Properties
    private var modelContext: ModelContext?
    var fetchedKana: [Kana] = []
    
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
    
    var currentIndex: Int = 0
    var isFront: Bool = true
    
    var filter: KanaFilter = .all {
        didSet {
            resetCurrentIndex()
            isFront = true
        }
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
                return fetchedKana.filter { kana in
                    kana.type == .hiragana && allowed.contains(kana.variant) && kana.dueDate <= Date()
                }
                    
            case .katakana:
                return fetchedKana.filter { kana in
                    kana.type == .katakana && allowed.contains(kana.variant) && kana.dueDate <= Date()
                }
                    
            case .all:
                return fetchedKana.filter { kana in
                    allowed.contains(kana.variant) && kana.dueDate <= Date()
                }
            }
        }
    
    var currentCard: Kana? {
        if filteredKana.isEmpty {
            return nil
        }
        return filteredKana[currentIndex]
    }
    
    var upcomingWeekForecast: [DailyForecast] {
        var forecast: [DailyForecast] = []
        for index in 0..<7 {
            let targetDate = Date().addingTimeInterval(60*60*24*Double(index))

            forecast.append(DailyForecast(date: targetDate, cardsDue: fetchedKana.filter {
                kana in Calendar.current.isDate(kana.dueDate, inSameDayAs: targetDate)
            }.count))
        }
        return forecast
    }
    
    var masteredCardsHistory: [Kana] {
        return fetchedKana.filter { kana in kana.dateMastered != nil
        }.sorted()
    }
    
    struct DailyForecast: Identifiable {
        var id: UUID = UUID()
        var date: Date
        var cardsDue: Int
        
    }
    
    // MARK: - Methods / Intents
    
    func fetchKana(modelContext: ModelContext) {
        self.modelContext = modelContext
        let descriptor = FetchDescriptor<Kana>()
        self.fetchedKana = (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func shuffleKanaCards() {
        fetchedKana.shuffle()
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
    
    func calculateRatings(ratingType: RatingType) {
        
        guard let currentCard else {
            return
        }
        
        switch ratingType {
        case .fail:
            currentCard.repetitions = 0
            currentCard.interval = 0
            currentCard.easeFactor = max(currentCard.easeFactor - 0.2, 1.3)
        case .hard:
            currentCard.repetitions += 1
            currentCard.interval = max(Int(Double(currentCard.interval) * 1.2), 1)
            currentCard.easeFactor = max(currentCard.easeFactor - 0.15, 1.3)
        case .good:
            currentCard.repetitions += 1
            if currentCard.repetitions == 1 {
                currentCard.interval = 1
            } else if currentCard.repetitions == 2 {
                currentCard.interval = 6
            } else if currentCard.repetitions > 2 {
                currentCard.interval = Int(Double(currentCard.interval) * currentCard.easeFactor)
            }
        case .easy:
            currentCard.repetitions += 1
            if currentCard.interval == 0 {
                currentCard.interval = 4
            } else {
                currentCard.interval = Int(Double(currentCard.interval) * currentCard.easeFactor * 1.3)
            }
            currentCard.easeFactor = max(currentCard.easeFactor + 0.15, 1.3)
        }
        // Calculate, set the card's new due date
        currentCard.dueDate = Calendar.current.date(byAdding: .day, value: currentCard.interval, to: Date()) ?? Date()
        // Set the last rating before saving
        currentCard.lastRating = ratingType
        // Check and see if the card is mastered
        if currentCard.interval >= 21 && currentCard.dateMastered == nil {
            currentCard.dateMastered = Date()
        }
        // Save database connection
        try? modelContext?.save()
        // Move to the next card
        nextCard()
    }
}
