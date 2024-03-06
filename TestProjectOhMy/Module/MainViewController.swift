//
//  ViewController.swift
//  TestProjectOhMy
//
//  Created by ADyatkov on 07.03.2024.
//

import Combine
import UIKit

final class MainViewController: UIViewController {

    // MARK: - Properties
    private var viewModel: MainViewModel
    private lazy var dataSource: MainDataSource = {
        let dataSource = MainDataSource(collectionView: collectionView)
        return dataSource
    }()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Subviews
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension.absolute(88)
            )
            let itemCount = 1
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            return section
        })
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.delegate = self

        collection.register([
            MainCollectionViewCell.self
        ])
        return collection
    }()

    // MARK: - Init/Deinit
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        binding()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        viewModel.viewDidLoad()
    }

    private func configure() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        layout()
    }

    private func layout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func binding() {
        viewModel.$snapshot
            .receive(on: DispatchQueue.main)
            .sink { [weak self] snapshot in
                self?.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &cancellables)
    }


}

extension MainViewController: UICollectionViewDelegate {}

