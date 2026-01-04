//
//  KanaView.swift
//  KanaCard
//
//  Created by Kevin Struna on 12/31/25.
//

import SwiftUI

struct KanaView: View {
    @State private var kanaViewModel = KanaViewModel()

    var body: some View {
        GeometryReader { mainProxy in
            NavigationStack {
                VStack {
                    Card(kanaViewModel: kanaViewModel)
                    
                    HStack {
                        Button(action: kanaViewModel.previousCard) {
                            Label("Back", systemImage: "arrow.left")
                        }
                        
                        Text(kanaViewModel.currentIndex.description + " / " + kanaViewModel.filteredKana.count.description)
                            .font(.system(size: mainProxy.size.height * 0.05, weight: .semibold, design: .rounded))
                            .padding()
                        
                        Button(action: kanaViewModel.nextCard) {
                            Label("Next", systemImage: "arrow.right")
                        }
                    }
                    .padding(.bottom)
                    .font(.system(size: mainProxy.size.height * 0.025, weight: .semibold, design: .rounded))
                    .lineLimit(1)
                    .labelStyle(.iconOnly)
                    .buttonStyle(.glassProminent)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Menu {
                            Text("KanaCard")
                            Text("App Version 1.0")
                            Text("Designed By Kevin Struna in Colorado")

                        } label: {
                            Label("Information", systemImage: "info.circle")
                        }
                        
                        Menu {
                            Button("All", systemImage: "a.circle", action: {kanaViewModel.filter = .all})
                            Button("Hiragana", systemImage: "h.circle", action: {kanaViewModel.filter = .hiragana})
                            Button("Katakana", systemImage: "k.circle", action: {kanaViewModel.filter = .katakana})
                        } label: {
                            Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                        }
                        
                        Menu {
                            Button("Reset Deck", systemImage: "restart.circle", action: {kanaViewModel.currentIndex = 0})
                            Button("Shuffle Deck", systemImage:  "shuffle.circle", action: kanaViewModel.shuffleKanaCards)
                            
                        } label: {
                            Label("Options", systemImage: "ellipsis.circle")
                        }
                    }
                }
            }
        }
    }
}

struct Card: View {
    @Bindable var kanaViewModel: KanaViewModel
    @State var dragDisplacement : CGSize = .zero

    var body: some View {
        
        let angle: Double = kanaViewModel.isFront ? 0.0 : 180.0
        let shadowX = -dragDisplacement.width / 10.0
        let shadowY = -dragDisplacement.height / 10.0
        let shadowAmount: Double = 5.0 + (15.0 * (1.0 - (abs(90 - angle) / 90.0)))
        
        GeometryReader { proxy in
            ZStack {
                if proxy.size.width < proxy.size.height {
                    // Sqaure card look
                    RoundedRectangle(cornerRadius: 22.0, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.cyan, Color.accentColor],
                                startPoint: angle > 90 ? .topTrailing : .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                                RadialGradient(
                                    colors: [.white.opacity(0.3), .clear],
                                    center: UnitPoint(
                                        x: 0.5 + (dragDisplacement.width / proxy.size.width),
                                        y: 0.5 + (dragDisplacement.height / proxy.size.height)
                                    ),
                                    startRadius: 0,
                                    endRadius: 200
                                )
                            )
                            .frame(maxWidth: proxy.size.width * 0.9, maxHeight: proxy.size.height * 0.6)
                } else {
                    // 3x5 card look
                    RoundedRectangle(cornerRadius: 22.0, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.cyan, Color.accentColor],
                                startPoint: angle > 90 ? .topTrailing : .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                                RadialGradient(
                                    colors: [.white.opacity(0.3), .clear],
                                    center: UnitPoint(
                                        x: 0.5 + (dragDisplacement.width / proxy.size.width),
                                        y: 0.5 + (dragDisplacement.height / proxy.size.height)
                                    ),
                                    startRadius: 0,
                                    endRadius: 200
                                )
                            )
                            .frame(maxWidth: proxy.size.width * 0.6, maxHeight: proxy.size.height * 0.9)
                }
                
                if angle < 90 {
                    Text(kanaViewModel.currentCard.character)
                        .foregroundStyle(Color.white)
                        .font(.system(size: proxy.size.width * 0.5, weight: .semibold, design: .rounded))
                        .rotation3DEffect(
                            .degrees(angle),
                            axis: (x: 0, y: 1, z: 0)
                        )
                } else {
                    Text(kanaViewModel.currentCard.romaji)
                        .foregroundStyle(Color.white)
                        .font(.system(size: proxy.size.width * 0.5, weight: .semibold, design: .rounded))
                        .rotation3DEffect(
                            .degrees(angle),
                            axis: (x: 0, y: 1, z: 0)
                        )
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            .shadow(radius: shadowAmount, x: shadowX, y: shadowY)
            .rotation3DEffect(
                .degrees(angle),
                axis: (x: 0, y: 1, z: 0)
            )
            .onTapGesture {
                withAnimation {
                    kanaViewModel.flipCard()
                }
            }
            .gesture(
                DragGesture(minimumDistance: 15)
                    .onChanged { value in
                        withAnimation(.interactiveSpring()) {
                            dragDisplacement = value.translation
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            if value.translation.width > 50 {
                                dragDisplacement.width = 1000.0
                            } else if value.translation.width < -50 {
                                dragDisplacement.width = -1000.0
                            } else {
                                dragDisplacement = .zero
                            }
                        } completion: {
                            if value.translation.width > 50 {
                                kanaViewModel.nextCard()
                                dragDisplacement = .zero
                            } else if value.translation.width < -50 {
                                kanaViewModel.previousCard()
                                dragDisplacement = .zero

                            }
                        }
                    }
            )
            .rotationEffect(Angle(degrees: dragDisplacement.width / 10.0), anchor: .center)
            .offset(dragDisplacement)
        }
    }
}

#Preview {
    KanaView()
}
