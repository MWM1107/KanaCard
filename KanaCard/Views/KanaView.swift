//
//  KanaView.swift
//  KanaCard
//
//  Created by Kevin Struna on 12/31/25.
//

import SwiftData
import SwiftUI

struct KanaView: View {
    @Environment(\.modelContext) private var context
    @State private var kanaViewModel = KanaViewModel()
    @State private var showSheet: Bool = false
    @AppStorage("appTheme") var appTheme: String = "Ocean"

    var midnightTonight: Date {
        let startOfToday = Calendar.current.startOfDay(for: Date())
        return Calendar.current.date(byAdding: .day, value: 1, to: startOfToday) ?? Date()
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { mainProxy in
                let buttonFrameSize = min(mainProxy.size.width * 0.07, mainProxy.size.height * 0.07)
                let mediumFontSize = max(mainProxy.size.width * 0.025, mainProxy.size.height * 0.025)
                let LargeFontSize = max(mainProxy.size.width * 0.05, mainProxy.size.height * 0.05)
                
                ZStack {
                    Color(appTheme).opacity(0.5)
                        .ignoresSafeArea()
                    VStack {
                        if kanaViewModel.filteredKana.isEmpty {
                            VStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .padding()
                                Text("You're all done for today!")
                                HStack {
                                    Image(systemName: "clock")
                                    Text(midnightTonight, style: .timer)
                                }
                                .padding(.top)
                                .font(.system(size: mediumFontSize, weight: .semibold, design: .monospaced))
                            }
                            .padding()
                            .foregroundStyle(Color.white)
                            .font(.system(size: LargeFontSize, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .background(
                                GlassCardBackground(kanaViewModel: kanaViewModel)
                            )
                            .aspectRatio(mainProxy.size.width < mainProxy.size.height ? 1/1 : 5/3, contentMode: .fit)
                            

                        } else {
                            CardView(kanaViewModel: kanaViewModel)
                                .sensoryFeedback(.impact(weight: .heavy), trigger: kanaViewModel.isFront)
                            if kanaViewModel.isFront {
                                HStack {
                                    Button(action: kanaViewModel.previousCard) {
                                        Label("Previous Card", systemImage: "arrow.left")
                                            .frame(width: buttonFrameSize, height: buttonFrameSize)
                                    }
                                    
                                    Text(kanaViewModel.currentIndex.description + " / " + kanaViewModel.filteredKana.count.description)
                                        .font(.system(size: LargeFontSize, weight: .semibold, design: .rounded))
                                        .padding()
                                    
                                    Button(action: kanaViewModel.nextCard) {
                                        Label("Next Card", systemImage: "arrow.right")
                                            .frame(width: buttonFrameSize, height: buttonFrameSize)
                                    }
                                }
                                .sensoryFeedback(.impact(weight: .light), trigger: kanaViewModel.currentIndex)
                                .padding(.bottom)
                                .font(.system(size: mediumFontSize, weight: .semibold, design: .rounded))
                                .lineLimit(1)
                                .labelStyle(.iconOnly)
                                .buttonStyle(.glassProminent)
                                
                            } else {
                                Text("How did you do?")
                                    .font(.system(size: mediumFontSize, weight: .semibold, design: .rounded))
                                    .padding()
                                    
                                HStack {
                                    Button(action: {
                                        kanaViewModel.calculateRatings(ratingType: .fail)
                                    }) {
                                        Label("Fail", systemImage: "xmark")
                                            .frame(width: buttonFrameSize, height: buttonFrameSize)
                                    }
                                    
                                    Button(action: {
                                        kanaViewModel.calculateRatings(ratingType: .hard)
                                    }) {
                                        Label("Hard", systemImage: "exclamationmark")
                                            .frame(width: buttonFrameSize, height: buttonFrameSize)
                                    }
                                    
                                    Button(action: {
                                        kanaViewModel.calculateRatings(ratingType: .good)
                                    }) {
                                        Label("Good", systemImage: "checkmark")
                                            .frame(width: buttonFrameSize, height: buttonFrameSize)
                                    }
                                    
                                    Button(action: {
                                        kanaViewModel.calculateRatings(ratingType: .easy)
                                    }) {
                                        Label("Easy", systemImage: "sparkles")
                                            .frame(width: buttonFrameSize, height: buttonFrameSize)
                                    }
                                }
                                .sensoryFeedback(.impact(weight: .medium), trigger: kanaViewModel.currentIndex)
                                .padding(.bottom)
                                .font(.system(size: mediumFontSize, weight: .semibold, design: .rounded))
                                .lineLimit(1)
                                .labelStyle(.iconOnly)
                                .buttonStyle(.glassProminent)
                            }
                        }
                    }
                    .animation(.snappy, value: kanaViewModel.currentIndex)
                    .sheet(isPresented: $showSheet) {
                        NavigationStack {
                            Form {
                                Section {
                                    Picker("Script", selection: $kanaViewModel.filter) {
                                        Text("All").tag(KanaFilter.all)
                                        Text("Hiragana").tag(KanaFilter.hiragana)
                                        Text("Katakana").tag(KanaFilter.katakana)
                                    }
                                    .pickerStyle(.segmented)
                                } header: {
                                    Label("Script", systemImage: "textformat")
                                } footer: {
                                    Text("Choose which script(s) to study.")
                                }
                                
                                Section {
                                    Grid {
                                        GridRow {
                                            FilterChipsView(title: "あ Basic", isOn: $kanaViewModel.isSeion)
                                            FilterChipsView(title: "が Voiced", isOn: $kanaViewModel.isDakuon)
                                            FilterChipsView(title: "ぱ Semi", isOn: $kanaViewModel.isHandakuon)
                                            FilterChipsView(title: "きゃ Combo", isOn: $kanaViewModel.isYoon)
                                        }
                                    }
                                } header: {
                                    Label("Kana Sets", systemImage: "square.grid.2x2")
                                } footer: {
                                    Text("Select which sets to include in your deck.")
                                }
                                
                                Section {
                                    Button("Reset Deck", systemImage: "restart.circle", action: {kanaViewModel.resetCurrentIndex()})
                                    Button("Shuffle Deck", systemImage:  "shuffle.circle", action: kanaViewModel.shuffleKanaCards)
                                } header: {
                                    Label("Quick Options", systemImage: "gear")
                                } footer: {
                                    Text("Make quick changes to your deck.")
                                }
                                
                                Section {
                                    Picker("App Theme", selection: $appTheme) {
                                        Text("Amethyst").tag("Amethyst")
                                        Text("Forest").tag("Forest")
                                        Text("Mint").tag("Mint")
                                        Text("Ocean").tag("Ocean")
                                        Text("Ruby").tag("Ruby")
                                        Text("Sunset").tag("Sunset")
                                    }
                                } header: {
                                    Label("App Theme", systemImage: "moon.circle")
                                } footer: {
                                    Text("Change the theme of the app.")
                                }
                                
                                Section {
                                    Link(destination: URL(string: " ")!) {
                                        Label("Contact Developer", systemImage: "envelope")
                                    }
                                    Link(destination: URL(string: " ")!) {
                                        Label("Privacy Policy", systemImage: "lock")
                                    }
                                    Link(destination: URL(string: " ")!) {
                                        Label("Terms and Conditions", systemImage: "doc")
                                    }
                                } header: {
                                    Label("Help & Information", systemImage: "info.circle")
                                } footer: {
                                    Text("Version 1.0 - Designed by Kevin Struna in Colorado")
                                }
                            }
                            .navigationTitle("Learning Options")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Done") { showSheet = false }
                                }
                            }
                        }
                    }
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    
                    .toolbar {
                        ToolbarItemGroup(placement: .primaryAction) {
                            NavigationLink(destination: StatsView(kanaViewModel: kanaViewModel)) {
                                Label("Stats", systemImage: "chart.bar")
                            }
                            Button(action: { showSheet.toggle() }) {
                                Label("Settings", systemImage: "gear")
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            kanaViewModel.fetchKana(modelContext: context)
        }
    }
}

#Preview {
    KanaView()
}
