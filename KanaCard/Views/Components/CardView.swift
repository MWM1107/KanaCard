//
//  CardView.swift
//  KanaCard
//
//  Created by Kevin Struna on 12/31/25.
//

import SwiftUI

struct CardView: View {
    @Bindable var kanaViewModel: KanaViewModel
    @State private var dragDisplacement : CGSize = .zero

    var body: some View {
        
        let angle: Double = kanaViewModel.isFront ? 0.0 : 180.0
        let shadowX = -dragDisplacement.width / 10.0
        let shadowY = -dragDisplacement.height / 10.0
        let shadowAmount: Double = 5.0 + (15.0 * (1.0 - (abs(90 - angle) / 90.0)))
        
        GeometryReader { proxy in
            ZStack {
                if proxy.size.width < proxy.size.height {
                    // Sqaure card look
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
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
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
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
    @Previewable @State var kanaViewModel = KanaViewModel()
    CardView(kanaViewModel: kanaViewModel)
}
