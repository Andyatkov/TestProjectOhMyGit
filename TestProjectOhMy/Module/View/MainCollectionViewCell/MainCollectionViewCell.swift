//
//  MainItemCollectionViewCell.swift
//  TestProjectOhMy
//
//  Created by ADyatkov on 07.03.2024.
//

import Combine
import UIKit

final class MainCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    private var items = [String]() {
        didSet {
            guard !oldValue.isEmpty, oldValue.count == items.count else {
                collectionView.reloadData()
                return
            }
            for index in 0..<items.count {
                if oldValue[index] != items[index] {
                    collectionView.reloadItems(at: [IndexPath(item: index, section: .zero)])
                }
            }
        }
    }

    // MARK: - Subviews
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.absolute(88),
                heightDimension: NSCollectionLayoutDimension.absolute(88)
            )
            let itemCount = 1
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
            let section = NSCollectionLayoutSection(group: group)
            return section
        })
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor.white
        collection.dataSource = self

        collection.register([
            MainItenCollectionViewCell.self
        ])
        return collection
    }()

    // MARK: - Init/Denit
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
        addSubviews()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        collectionView.setContentOffset(.zero, animated: false)
    }

    // MARK: - Private methods
    private func configure() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        collectionView.backgroundColor = .white
    }

    private func addSubviews() {
        contentView.addSubview(collectionView)
    }

    private func layout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(viewModel: MainCollectionViewModel) {
        items = viewModel.items
    }
}

extension MainCollectionViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(MainItenCollectionViewCell.self, for: indexPath)
        if items.count > indexPath.item {
            cell.configure(text: items[indexPath.item])
        }
        return cell
    }
}
