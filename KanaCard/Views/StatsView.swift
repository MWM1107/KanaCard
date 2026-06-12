//
//  StatsView.swift
//  KanaCard
//
//  Created by Kevin Struna on 6/10/26.
//

import SwiftData
import SwiftUI

struct StatsView: View {
    @Bindable var kanaViewModel: KanaViewModel
    @AppStorage("appTheme") var appTheme: String = "Ocean"
    var masteredDate: Date {
        Calendar.current.date(byAdding: .day, value: 21, to: Date()) ?? Date()
    }
    var futureCards: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.dueDate > Date() }.count
    }
    var dueCards: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.dueDate <= Date() }.count
    }
    var masteredCards: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.dueDate > masteredDate }.count
    }
    var learningCards: Int {
        return kanaViewModel.fetchedKana.count - masteredCards
    }
    var hiraganaMastered: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.type == .hiragana && kana.dueDate > masteredDate }.count
    }
    var katakanaMastered: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.type == .katakana && kana.dueDate > masteredDate }.count
    }
    var totalHiragana: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.type == .hiragana }.count
    }
    var totalKatakana: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.type == .katakana }.count
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(appTheme).opacity(0.5)
                    .ignoresSafeArea()
                ScrollView {
                    // Daily Snapshot Section
                    VStack {
                        Text("Your Daily Snapshot")
                            .font(Font.custom("Avenir-Black", size: 24))
                        HStack {
                            VStack {
                                Text(futureCards.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                Text("Cards scheduled")
                                    .font(Font.callout)
                            }
                            VStack {
                                Text(dueCards.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                Text("Cards due today")
                                    .font(Font.callout)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .background(
                        GlassCardBackground(kanaViewModel: kanaViewModel)
                    )
                    
                    // Deck Mastery
                    VStack {
                        Text("Your Deck Mastery")
                            .font(Font.custom("Avenir-Black", size: 24))
                        HStack {
                            VStack {
                                Text(masteredCards.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                Text("Cards mastered")
                                    .font(Font.callout)
                                
                            }
                            VStack {
                                Text(learningCards.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                Text("Cards to learn")
                                    .font(Font.callout)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .background(
                        GlassCardBackground(kanaViewModel: kanaViewModel)
                    )
                    
                    // Script Breakdown
                    VStack {
                        Text("Your Script Breakdown")
                            .font(Font.custom("Avenir-Black", size: 24))
                        HStack {
                            VStack {
                                Text(hiraganaMastered.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                ProgressView(value: Double(hiraganaMastered), total: Double(totalHiragana))
                                    .progressViewStyle(LinearProgressViewStyle())
                                Text("Hiragana mastered")
                                    .font(Font.callout)
                            }
                            VStack {
                                Text(katakanaMastered.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                ProgressView(value: Double(katakanaMastered), total: Double(totalKatakana))
                                    .progressViewStyle(LinearProgressViewStyle())
                                Text("Katakana mastered")
                                    .font(Font.callout)
                            }
                        }
                    }
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .background(
                        GlassCardBackground(kanaViewModel: kanaViewModel)
                    )
                    
                }
                .navigationTitle("Progress and Stats")
            }
        }
    }
}

#Preview {
    @Previewable @State var kanaViewModel = KanaViewModel()
    StatsView(kanaViewModel: kanaViewModel)
}
