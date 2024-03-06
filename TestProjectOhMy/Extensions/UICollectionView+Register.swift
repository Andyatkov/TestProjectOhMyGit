//
//  UICollectionView+Register.swift
//  TestProjectOhMy
//
//  Created by ADyatkov on 07.03.2024.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }

    func register(_ types: [UICollectionViewCell.Type]) {
        for type in types {
            register(type, forCellWithReuseIdentifier: String(describing: type.self))
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T
        else { fatalError("Couldn't find UICollectionViewCell for \(String(describing: T.self))") }
        return cell
    }

}

extension UICollectionViewCell {

    static var reuseIdentifier: String {
        String(describing: self)
    }

}

