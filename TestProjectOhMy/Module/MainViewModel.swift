//
//  MainViewModel.swift
//  TestProjectOhMy
//
//  Created by ADyatkov on 07.03.2024.
//

import Combine
import UIKit

final class MainViewModel {

    // MARK: - Output
    @Published var snapshot = MainDataSource.Snapshot()
    private var cancellables = Set<AnyCancellable>()

    init() {
        binding()
    }

    // MARK: - Public methods
    func viewDidLoad() {
        snapshot.appendSections([.main])

        let sectionCount = Int.random(in: 100..<200)
        let itemsCount = Int.random(in: 10..<20)
        for _ in 0..<sectionCount {
            var items = [String]()
            for _ in 0..<itemsCount {
                items.append("\(Int.random(in: 0..<1000))")
            }
            snapshot.appendItems([.item(viewModel: MainCollectionViewModel(items: items))], toSection: .main)
        }
    }

    func binding() {
        let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)

        timerPublisher.autoconnect().sink { [weak self] _ in
            self?.updateItems()
        }
        .store(in: &cancellables)
    }

    func updateItems() {
        let items = snapshot.itemIdentifiers(inSection: .main)
        for item in items {
            switch item {
            case .item(let viewModel):
                viewModel.items[Int.random(in: 0..<viewModel.items.count)] = "\(Int.random(in: 0..<1000))"
            }
        }
        snapshot.reconfigureItems(items)
    }
}
