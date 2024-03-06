//
//  MainItemCollectionViewModel.swift
//  TestProjectOhMy
//
//  Created by ADyatkov on 07.03.2024.
//

import Foundation

final class MainCollectionViewModel {

    let id = UUID()
    var items: [String]

    init(items: [String]) {
        self.items = items
    }
}

extension MainCollectionViewModel: Hashable, Equatable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    
    static func == (lhs: MainCollectionViewModel, rhs: MainCollectionViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
