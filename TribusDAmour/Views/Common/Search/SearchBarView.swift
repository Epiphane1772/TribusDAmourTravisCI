//
//  SearchBarView.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023/08/11.
//  Copyright © 2023 SEL Consulting. All rights reserved.
//

import SwiftUI

// View representing a search bar for podcast search
struct SearchBarView: View {
    @Binding var text: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            // Text field for entering search text
            TextField("Search...", text: $text, onCommit: onSearch)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .accessibility(identifier: "searchTextField")
                .accessibility(label: Text("Search podcasts"))
                .accessibility(hint: Text("Enter podcast name or keywords"))
                .accessibility(addTraits: .isSearchField)

            // Button for initiating search
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            .accessibility(identifier: "searchButton")
            .accessibility(label: Text("Search button"))
            .accessibility(hint: Text("Tap to search podcasts with the entered text"))
            .accessibilityAction(named: Text("Search"), onSearch)
        }
        .padding(.horizontal)
    }
}
