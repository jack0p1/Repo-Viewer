//
//  RepoTableViewCell.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 12/12/2020.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    //MARK: Properties
    private lazy var contentStackView = makeStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: -1, height: 92)
    }
    
    private func commonInit() {
        backgroundColor = .lightGray
        layer.cornerRadius = 13
        
        contentView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func makeStackView() -> UIStackView {
        let sV = UIStackView()
        sV.axis = .horizontal
        sV.spacing = 16
        
        return sV
    }
    
}
