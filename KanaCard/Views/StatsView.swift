//
//  StatsView.swift
//  KanaCard
//
//  Created by Kevin Struna on 6/10/26.
//

import SwiftData
import SwiftUI
import Charts

struct StatsView: View {
    @Bindable var kanaViewModel: KanaViewModel
    @AppStorage("appTheme") var appTheme: String = "Ocean"
    var masteredDate: Date {
        Calendar.current.date(byAdding: .day, value: 21, to: Date()) ?? Date()
    }
    var futureCards: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.dueDate > Date() }.count
    }
    var easyCards: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.lastRating == .easy }.count
    }
    var goodCards: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.lastRating == .good }.count
    }
    var hardCards: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.lastRating == .hard }.count
    }
    var failCards: Int {
        return kanaViewModel.fetchedKana.filter { kana in kana.lastRating == .fail }.count
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
                    // MARK: - Daily Snapshot Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Daily Snapshot")
                            .font(Font.title.bold())
                        HStack {
                            VStack {
                                Text(futureCards.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                Label("Cards scheduled", systemImage: "calendar.badge.clock")
                                    .font(Font.callout)
                            }
                            Spacer()
                            VStack {
                                Text(dueCards.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                Label("Cards due today", systemImage: "calendar.badge.exclamationmark")
                                    .font(Font.callout)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.white)
                    .background(
                        GlassCardBackground(kanaViewModel: kanaViewModel)
                    )
                    
                    // MARK: - Deck Mastery
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Deck Mastery")
                            .font(Font.title.bold())
                        HStack {
                            VStack {
                                Text(masteredCards.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                Label("Cards mastered", systemImage: "app.badge.checkmark.fill")
                                    .font(Font.callout)
                                
                            }
                            Spacer()
                            VStack {
                                Text(learningCards.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                Label("Cards to learn", systemImage: "app.badge.clock.fill")
                                    .font(Font.callout)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.white)
                    .background(
                        GlassCardBackground(kanaViewModel: kanaViewModel)
                    )
                    
                    // MARK: - Script Breakdown
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Script Breakdown")
                            .font(Font.title.bold())
                        HStack {
                            VStack {
                                Text(hiraganaMastered.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                ProgressView(value: Double(hiraganaMastered), total: Double(totalHiragana))
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .padding()
                                Label("Hiragana mastered", systemImage: "h.square")
                                    .font(Font.callout)
                                    .lineLimit(1)
                            }
                            Spacer()
                            VStack {
                                Text(katakanaMastered.description)
                                    .font(Font.largeTitle.bold().monospaced())
                                ProgressView(value: Double(katakanaMastered), total: Double(totalKatakana))
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .padding()
                                Label("Katakana mastered", systemImage: "k.square")
                                    .font(Font.callout)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        GlassCardBackground(kanaViewModel: kanaViewModel)
                    )
                    
                    // MARK: - Pie Chart Rating Breakdown
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Rating Breakdown")
                            .font(Font.title.bold())
                        Chart {
                            SectorMark(angle: .value("Easy", easyCards))
                                .foregroundStyle(by: .value("Rating", "Easy"))
                            SectorMark(angle: .value("Good", goodCards))
                                .foregroundStyle(by: .value("Rating", "Good"))
                            SectorMark(angle: .value("Hard", hardCards))
                                .foregroundStyle(by: .value("Rating", "Hard"))
                            SectorMark(angle: .value("Fail", failCards))
                                .foregroundStyle(by: .value("Rating", "Fail"))
                        }
                        .chartForegroundStyleScale([
                            "Easy": .blue,
                            "Good": .green,
                            "Hard": .yellow,
                            "Fail": .red
                        ])
                    }
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        GlassCardBackground(kanaViewModel: kanaViewModel)
                    )
                    
                }
                .padding()
                .navigationTitle("Progress and Stats")
            }
        }
    }
}

#Preview {
    @Previewable @State var kanaViewModel = KanaViewModel()
    StatsView(kanaViewModel: kanaViewModel)
}
