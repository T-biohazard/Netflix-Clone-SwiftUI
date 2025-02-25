//
//  Created by Tahsin on 2/25/25.
//
//latest 26 feb

import SwiftUI

struct CategoriesView: View {
    let categories = ["Coming Soon", "Everyone’s Watching", "Top Movies", "Top TV Shows"]
    
    // 1) This must be a Binding to let the parent control the selection:
    @Binding var selectedCategory: String

    @Namespace private var animation
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(categories, id: \.self) { category in
                    CategoryButton(
                        category: category,
                        isSelected: (category == selectedCategory),
                        animation: animation
                    ) {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            // 2) Update the parent’s selectedCategory:
                            selectedCategory = category
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - CategoryButton

struct CategoryButton: View {
    let category: String
    let isSelected: Bool
    let animation: Namespace.ID
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(
                    ZStack {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.2))
                                .frame(height: 30)
                                .matchedGeometryEffect(id: "categoryIndicator", in: animation)
                        }
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

// MARK: - Preview

struct CategoriesView_Previews: PreviewProvider {
    // Provide a demo Binding:
    @State static var selectedCat = "Coming Soon"
    
    static var previews: some View {
        CategoriesView(selectedCategory: $selectedCat)
            .preferredColorScheme(.dark)
    }
}
