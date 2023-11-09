//
//  ResultCollectionViewCell.swift
//  DiceCount
//
//  Created by Roland Keesom on 08/03/2023.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
