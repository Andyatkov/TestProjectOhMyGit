//
//  MainItemCollectionViewCell.swift
//  TestProjectOhMy
//
//  Created by ADyatkov on 07.03.2024.
//

import Combine
import UIKit

final class MainItenCollectionViewCell: UICollectionViewCell {

    lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .cyan
        backView.translatesAutoresizingMaskIntoConstraints = false
        let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: CGSize(width: 88, height: 88)), cornerRadius: 8)

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        backView.layer.mask = maskLayer

        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.lineWidth = 2
        borderLayer.strokeColor = UIColor.red.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        backView.layer.addSublayer(borderLayer)

        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        backView.addGestureRecognizer(tapGesture)
        backView.isUserInteractionEnabled = true
        return backView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

    // MARK: - Private methods
    private func configure() {
        contentView.backgroundColor = .white
    }

    private func addSubviews() {
        contentView.addSubview(backView)
        contentView.addSubview(titleLabel)
    }

    private func layout() {
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    @objc private func handleTap(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.backView.transform = .identity
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.backView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }

    // MARK: - Public methods
    func configure(text: String) {
        titleLabel.text = text
    }
}
