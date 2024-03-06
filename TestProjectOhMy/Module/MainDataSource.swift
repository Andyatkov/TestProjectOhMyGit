//
//  MainDataSource.swift
//  TestProjectOhMy
//
//  Created by ADyatkov on 07.03.2024.
//

import UIKit

final class MainDataSource: UICollectionViewDiffableDataSource<MainSectionType, MainItemType> {

    // MARK: - Typealias
    typealias Snapshot = NSDiffableDataSourceSnapshot<MainSectionType, MainItemType>

    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .item(let viewModel):
                let cell = collectionView.dequeueReusableCell(MainCollectionViewCell.self, for: indexPath)
                cell.configure(viewModel: viewModel)
                return cell
            }
        }
    }

}
