//
//  MainItemType.swift
//  TestProjectOhMy
//
//  Created by ADyatkov on 07.03.2024.
//

import Foundation

enum MainSectionType: Hashable {
    case main
}

enum MainItemType: Hashable {
    case item(viewModel: MainCollectionViewModel)
}
