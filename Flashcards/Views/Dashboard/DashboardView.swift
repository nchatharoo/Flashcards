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
    @ObservedObject var viewModel: QuestionViewModel

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                    ScrollView {
                        VStack(spacing: 0) {
                            // Vue Intermédiaire qui agit comme une "barrière" pour le calendrier
                            Color.clear
                                .frame(height: isExpanded ? 300 : 0) // Ajuste la hauteur pour créer la "barrière"
                                .background(GeometryReader { geometry in
                                    Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
                                })
                                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                        if value < 100 {
                                            isExpanded = false
                                        } else {
                                            isExpanded = true
                                        }
                                    }
                                }
                                .frame(height: 480)
                            
                            VStack(spacing: 20) {
                                ForEach(Question.Category.allCases, id: \.self) { category in
                                    ProgressBarView(
                                        category: category,
                                        score: viewModel.calculateScoreByCategory()[category] ?? (correct: 0, total: 0)
                                    )
                                }
                            }
                            .padding()
                        }
                    }
                
                ZStack(alignment: .top) {
                    Color(#colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1))
                        .frame(maxWidth: .infinity, maxHeight: isExpanded ? 450 : 150)
                    CalendarView(isExpanded: $isExpanded, animation: animation)
                        .frame(maxWidth: .infinity, maxHeight: isExpanded ? 450 : 150)
                        .background(Color(#colorLiteral(red: 0, green: 0.3414323926, blue: 0.3324367404, alpha: 1)))
                        .cornerRadius(16)
                        .shadow(radius: 8)
                        .padding()
                        .zIndex(1)
                }
            }
        }
    }
}

// MARK: - Custom ScrollOffset PreferenceKey
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    let viewModel = QuestionViewModel.preview
    DashboardView(viewModel: viewModel)
}
