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
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                    ScrollView {
                        VStack(spacing: 0) {
                            Color.clear
                                .frame(height: isExpanded ? 300 : 0)
                                .background(alignment: .top, content: {
                                    GeometryReader { geometry in
                                        Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
                                    }
                                })
                                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
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
                        }
                    }
                    .scrollIndicators(.never)
                
                ZStack {
                    Color(colorScheme == .dark ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.9999960065, green: 0.9998990893, blue: 0.9968855977, alpha: 1))
                        .frame(maxHeight: isExpanded ? 450 : 200)
                    CalendarView(isExpanded: $isExpanded, animation: animation)
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
