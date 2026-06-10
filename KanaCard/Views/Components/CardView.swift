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
    @AppStorage("appTheme") var appTheme: String = "Ocean"

    var body: some View {
        
        let angle: Double = kanaViewModel.isFront ? 0.0 : 180.0
        let shadowX = -dragDisplacement.width / 10.0
        let shadowY = -dragDisplacement.height / 10.0
        let shadowAmount: Double = 5.0 + (15.0 * (1.0 - (abs(90 - angle) / 90.0)))
        
        GeometryReader { proxy in
            ZStack {
                if proxy.size.width < proxy.size.height {
                    // Sqaure card look
                    GlassCardBackground(kanaViewModel: kanaViewModel)
                            .aspectRatio(1/1, contentMode: .fit)
                            .padding()
                } else {
                    // 3x5 card look
                    GlassCardBackground(kanaViewModel: kanaViewModel)
                            .aspectRatio(5/3, contentMode: .fit)
                            .padding()
                }
                
                if angle < 90 {
                    if let currentFacingCard = kanaViewModel.currentCard {
                        Text(currentFacingCard.character)
                            .foregroundStyle(Color.white)
                            .font(.system(size: min(proxy.size.width * 0.4, proxy.size.height * 0.4), weight: .semibold, design: .rounded))
                            .rotation3DEffect(
                                .degrees(angle),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                } else {
                    if let currentFacingCard = kanaViewModel.currentCard {
                        Text(currentFacingCard.romaji)
                            .foregroundStyle(Color.white)
                            .font(.system(size: min(proxy.size.width * 0.4, proxy.size.height * 0.4), weight: .semibold, design: .rounded))
                            .rotation3DEffect(
                                .degrees(angle),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
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
