//
//  Grid.swift
//  Memorize
//
//  Creates a Grid-based container for card views using generic input parameters.
//  Created by Pao Yu on 2021-04-23.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    private var items: [Item]                       // array of data that conforms to Indentifiable protocol
    private var viewForItem: (Item) -> ItemView     // function that returns a view using another view
    
    // Initialize the Grid view with an array of items
    // Initialize the Grid view with a function that can be called after initialization (escaping)
    public init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    public var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            body(for: item, in:layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        
        let index = items.firstIndex(matching: item)!
        
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
}
