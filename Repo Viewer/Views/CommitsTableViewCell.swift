//
//  CommitsTableViewCell.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 13/12/2020.
//

import UIKit

class CommitsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var contentStackView = makeContentStackView()
    private lazy var commitsDetailsStackView = makeCommitsDetailsStackView()
    private lazy var commitNumberLabel = makeCommitNumberLabel()
    private lazy var authorNameLabel = makeAuthorNameLabel()
    private lazy var authorEmailLabel = makeAuthorMailLabel()
    private lazy var commitMessageLabel = makeCommitMessageLabel()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Common init and populate cells
    private func commonInit() {
        contentView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: K.Margins.cellLeading + 4),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: K.Margins.cellTrailing),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            commitNumberLabel.heightAnchor.constraint(equalToConstant: 36),
            commitNumberLabel.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        contentStackView.addArrangedSubview(commitNumberLabel)
        commitsDetailsStackView.addArrangedSubview(authorNameLabel)
        commitsDetailsStackView.addArrangedSubview(authorEmailLabel)
        commitsDetailsStackView.addArrangedSubview(commitMessageLabel)
        contentStackView.addArrangedSubview(commitsDetailsStackView)
    }
    
    func populateCell(authorName: String, authorEmailAddress: String, commitMessage: String, commitNumber: Int) {
        authorNameLabel.text = authorName
        authorEmailLabel.text = authorEmailAddress
        commitMessageLabel.text = commitMessage
        commitNumberLabel.text = "\(commitNumber)"
    }
    
    // MARK: - Computing properties
    private func makeContentStackView() -> UIStackView {
        let sV = UIStackView()
        sV.axis = .horizontal
        sV.spacing = 20
        sV.alignment = .top
        sV.contentMode = .topLeft
        return sV
    }
    
    private func makeCommitsDetailsStackView() -> UIStackView {
        let sV = UIStackView()
        sV.axis = .vertical
        sV.spacing = 2
        sV.backgroundColor = .white
        return sV
    }
    
    private func makeCommitNumberLabel() -> UILabel {
        let size: CGFloat = 36
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        label.layer.cornerRadius = size / 2
        label.layer.masksToBounds = true
        return label
    }
    
    private func makeAuthorNameLabel() -> UILabel {
        let label = UILabel()
        label.text = "COMMIT AUTHOR NAME"
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .systemBlue
        return label
    }
    
    private func makeAuthorMailLabel() -> UILabel {
        let label = UILabel()
        label.text = "email@authorname.com"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }
    
    private func makeCommitMessageLabel() -> UILabel {
        let label = UILabel()
        label.text = "This is a commit message that needs to fold over to the next line."
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        label.numberOfLines = 0
        return label
    }
}
