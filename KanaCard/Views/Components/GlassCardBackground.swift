//
//  GlassCardBackground.swift
//  KanaCard
//
//  Created by Kevin Struna on 6/9/26.
//

import SwiftUI

struct GlassCardBackground: View {
    @Bindable var kanaViewModel: KanaViewModel
    @State private var dragDisplacement : CGSize = .zero
    @AppStorage("appTheme") var appTheme: String = "Ocean"

    
    var body: some View {
        let angle: Double = kanaViewModel.isFront ? 0.0 : 180.0

        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(appTheme).mix(with: .white, by: 0.4), Color(appTheme)],
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
        }
    }
}

#Preview {
    @Previewable @State var kanaViewModel = KanaViewModel()
    GlassCardBackground(kanaViewModel: kanaViewModel)
}
