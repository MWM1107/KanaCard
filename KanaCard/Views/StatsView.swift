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
                    TabView {
                        // MARK: - Daily Snapshot Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Daily Snapshot")
                                .font(Font.title.bold())
                            Text("Here's a quick snapshot of what's to come.")
                                .font(Font.subheadline)
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
                            Spacer()
                        }
                        
                        // MARK: - Deck Mastery
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Deck Mastery")
                                .font(Font.title.bold())
                            Text("A look at your mastery of the entire deck.")
                                .font(Font.subheadline)
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
                            Spacer()
                        }
                        
                        // MARK: - Script Breakdown
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Script Breakdown")
                                .font(Font.title.bold())
                            Text("Breakdown of mastery for each script.")
                                .font(Font.subheadline)
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
                            Spacer()
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 300, alignment: .leading)
                    .background(
                        GlassCardBackground(kanaViewModel: kanaViewModel)
                    )
                    
                    TabView {
                        // MARK: - Pie Chart Rating Breakdown
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Rating Breakdown")
                                .font(Font.title.bold())
                            Text("Your rating so far, broken down by difficulty.")
                                .font(Font.subheadline)
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
                            .padding()
                            .chartForegroundStyleScale([
                                "Easy": .blue,
                                "Good": .green,
                                "Hard": .yellow,
                                "Fail": .red
                            ])
                            
                            Spacer()
                        }
                        
                        // MARK: - Bar Chart Week Ahead
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Week Ahead")
                                .font(Font.title.bold())
                            Text("Looking ahead to the week, how many cards you have to learn.")
                                .font(Font.subheadline)
                            Chart {
                                ForEach(kanaViewModel.upcomingWeekForecast) { day in
                                    BarMark(x: .value("Day", day.date, unit: .day), y: .value("Cards Due", day.cardsDue))
                                }
                            }
                            .padding()
                            
                            Spacer()
                        }
                        
                        // MARK: - Line Chart Mastery Over Time
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Mastery Over Time")
                                .font(Font.title.bold())
                            Text("How many cards you have mastered over time.")
                                .font(Font.subheadline)
                            Chart {
                                ForEach(Array(kanaViewModel.masteredCardsHistory.enumerated()), id: \.element.id) { index, kana in
                                    LineMark(x: .value("Day", kana.dateMastered!, unit: .day), y: .value("Mastery", index + 1))
                                }
                            }
                            .padding()
                            
                            Spacer()
                            
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .padding()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 300, alignment: .leading)
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
