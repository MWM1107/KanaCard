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
    
    var body: some View {
        Button(action: {
            withAnimation {
                isOn.toggle()
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
    }
}

#Preview {
    FilterChipsView(title: "Test", isOn: .constant(true))
}
