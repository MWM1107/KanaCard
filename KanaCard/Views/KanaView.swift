//
//  KanaView.swift
//  KanaCard
//
//  Created by Kevin Struna on 12/31/25.
//

import SwiftUI

struct KanaView: View {
    @State private var kanaViewModel = KanaViewModel()
    @State private var showSheet: Bool = false
    // @State private var backgroundColor: Color = .white

    var body: some View {
        GeometryReader { mainProxy in
            NavigationStack {
                VStack {
                    CardView(kanaViewModel: kanaViewModel)
                    HStack {
                        Button(action: kanaViewModel.previousCard) {
                            Label("Previous Card", systemImage: "arrow.left")
                        }
                            
                        Text(kanaViewModel.currentIndex.description + " / " + kanaViewModel.filteredKana.count.description)
                                .font(.system(size: mainProxy.size.height * 0.05, weight: .semibold, design: .rounded))
                                .padding()
                        
                        Button(action: kanaViewModel.nextCard) {
                            Label("Next Card", systemImage: "arrow.right")
                        }
                    }
                    .padding(.bottom)
                    .font(.system(size: mainProxy.size.height * 0.025, weight: .semibold, design: .rounded))
                    .lineLimit(1)
                    .labelStyle(.iconOnly)
                    .buttonStyle(.glassProminent)
                }
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
                        .tint(.accentColor)
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
                        Button(action: { showSheet.toggle() }) {
                            Label("Settings", systemImage: "gear")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    KanaView()
}
