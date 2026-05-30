//
//  FilterChipsView.swift
//  KanaCard
//
//  Created by Kevin Struna on 04/27/26.
//

import SwiftUI

struct FilterChipsView: View {
    let title: String
    @Binding var isOn: Bool
    @State private var isJiggling: Bool = false
    
    var body: some View {
        Button(action: {
            isOn.toggle()
            isJiggling = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
                isJiggling = false
            }
        }){
            HStack {
                Text(title)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isOn ? Color.accentColor : Color(.systemGray6))
            .foregroundColor(isOn ? .white : .primary)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isOn ? Color.blue : Color.clear, lineWidth: 1)
            )

        }
        .buttonStyle(.plain)
        .rotationEffect(.degrees(isJiggling ? 5 : 0))
        .scaleEffect(isJiggling ? 1.1 : 1)
        .animation(
            .easeInOut(duration: 0.10).repeatCount(3, autoreverses: true), value: isJiggling,
        )
    }
}

#Preview {
    FilterChipsView(title: "Test", isOn: .constant(true))
}
