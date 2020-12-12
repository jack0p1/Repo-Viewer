//
//  RepoTableViewCell.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 12/12/2020.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var contentStackView = makeContentStackView()
    private lazy var verticalStackView = makeVerticalStackView()
    private lazy var horizontalStackView = makeHorizontalStackView()
    private lazy var thumbnailImageView = makePhotoImageView()
    private lazy var repoTitleLabel = makeRepoTitleLabel()
    private lazy var starImageView = makeStarImageView()
    private lazy var starsNumberLabel = makeStarNumberLabel()
    private lazy var forwardImageView = makeForwardImageView()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
//    }
    func setupCell(repoTitle: String, thumbnail: UIImage, numberOfStars: Int) {
        thumbnailImageView.image = thumbnail
        repoTitleLabel.text = repoTitle
        starsNumberLabel.text = "\(numberOfStars)"
    }
    
    private func commonInit() {
        backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        layer.cornerRadius = 13
        
        contentView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 60),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        contentStackView.addArrangedSubview(thumbnailImageView)
        
        horizontalStackView.addArrangedSubview(starImageView)
        NSLayoutConstraint.activate([
            starImageView.heightAnchor.constraint(equalToConstant: 14),
            starImageView.widthAnchor.constraint(equalToConstant: 14)
        ])
        
        horizontalStackView.addArrangedSubview(starsNumberLabel)
        
        verticalStackView.addArrangedSubview(repoTitleLabel)
        
        verticalStackView.addArrangedSubview(horizontalStackView)

        contentStackView.addArrangedSubview(verticalStackView)
        
        contentStackView.addArrangedSubview(forwardImageView)
        forwardImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forwardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            forwardImageView.heightAnchor.constraint(equalToConstant: 13),
            forwardImageView.widthAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    //MARK: - Computing properties
    private func makeContentStackView() -> UIStackView {
        let sV = UIStackView()
        sV.axis = .horizontal
        sV.spacing = 16
        sV.alignment = .center
        return sV
    }
    
    private func makePhotoImageView() -> UIImageView {
        let iV = UIImageView()
        iV.backgroundColor = .lightGray
        iV.layer.cornerRadius = 10
        return iV
    }
    
    private func makeRepoTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Repo Title"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }
    
    private func makeVerticalStackView() -> UIStackView {
        let sV = UIStackView()
        sV.axis = .vertical
        sV.spacing = 4
        return sV
    }
    
    private func makeStarImageView() -> UIImageView {
        let iV = UIImageView(image: UIImage(named: "starIcon.png"))
        return iV
    }
    
    private func makeStarNumberLabel() -> UILabel {
        let label = UILabel()
        label.text = "000"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        return label
    }
    
    private func makeHorizontalStackView() -> UIStackView {
        let sV = UIStackView()
        sV.axis = .horizontal
        sV.spacing = 4
        return sV
    }
    
    private func makeForwardImageView() -> UIImageView {
        let iV = UIImageView(image: UIImage(named: "forwardIcon.png"))
        return iV
    }
    
}
