//
//  DashboardView.swift
//  Flashcards
//
//  Created by Nadheer on 14/11/2024.
//

import SwiftUI

struct DashboardView: View {
    @Namespace private var animation
    @State private var isExpanded = true
    
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geometry in
                    CalendarView(isExpanded: $isExpanded, animation: animation)
                        .frame(maxWidth: .infinity, maxHeight: isExpanded ? 450 : 150)
                        .background(Color(#colorLiteral(red: 0, green: 0.3414323926, blue: 0.3324367404, alpha: 1)))
                        .cornerRadius(16)
                        .shadow(radius: 8)
                        .onChange(of: geometry.frame(in: .global).minY) { oldValue, newValue in
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                if newValue < -50 {
                                    isExpanded = false
                                } else if oldValue > 100 {
                                    isExpanded = true
                                }
                            }
                        }
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                isExpanded.toggle()
                            }
                        }
                }
                .frame(height: isExpanded ? 450 : 150)
                
                // Contenu fictif pour démontrer le scroll
                VStack(spacing: 20) {
                    ForEach(1...10, id: \.self) { index in
                        Text("Contenu \(index)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    DashboardView()
}
