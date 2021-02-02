//
//  DetailsViewController.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 11/12/2020.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController, Storyboarded {
    
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    private var serviceManager: ServiceManager?
    private var commitsPreviews: [CommitPreview]?
    var repoPreview: RepoPreview?
    
    // MARK: - UI Elements
    private lazy var thumbnailImageView = UIImageView()
    private lazy var repoByLabel = UILabel()
    private lazy var repoAuthorNameLabel = UILabel()
    private lazy var starsNumberLabel = UILabel()
    private lazy var starIconImageView = UIImageView()
    private lazy var starsStackView = UIStackView()
    private lazy var repoTitleLabel = UILabel()
    private lazy var viewOnlineButton = UIButton(type: .system)
    private lazy var repoTitleStackView = UIStackView()
    private lazy var commitsHistoryLabel = UILabel()
    private lazy var commitsTableView = UITableView()
    private lazy var shareButton = UIButton(type: .roundedRect)
    private lazy var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceManager = ServiceManager()
        serviceManager?.commitsDetailsDelegate = self
        if let title = repoPreview?.repoTitle, let owner = repoPreview?.ownerName {
            serviceManager?.getDetailsFor(repository: title, owner: owner)
        }
        setupThumbnail()
        setupRepoByLabel()
        setupRepoAuthorNameLabel()
        setupStarIconImageView()
        setupStarsNumberLabel()
        setupStarsStackView()
        setupRepoTitleLabel()
        setupViewOnlineButton()
        setupRepoTitleStackView()
        setupCommitsHistoryLabel()
        setupShareButton()
        setupCommitsTableView()
        setupActivityIndicator()
        
        activityIndicator.startAnimating()
    }
    
    // MARK: - Setting up the view
    private func setupThumbnail() {
        view.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.backgroundColor = .lightGray
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        if let url = repoPreview?.avatarURL {
            AF.download(url).responseData { [weak self] response in
                if let data = response.value {
                    let image = UIImage(data: data)
                    self?.thumbnailImageView.image = image
                }
            }
        }
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: view.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 263)
        ])
    }
    
    private func setupRepoByLabel() {
        view.addSubview(repoByLabel)
        repoByLabel.translatesAutoresizingMaskIntoConstraints = false
        repoByLabel.text = "REPO BY"
        repoByLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        repoByLabel.textColor = UIColor(white: 1, alpha: 0.6)
        
        NSLayoutConstraint.activate([
            repoByLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 159),
            repoByLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repoByLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ])
    }
    
    private func setupRepoAuthorNameLabel() {
        view.addSubview(repoAuthorNameLabel)
        repoAuthorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repoAuthorNameLabel.text = repoPreview?.ownerName
        repoAuthorNameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        repoAuthorNameLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            repoAuthorNameLabel.topAnchor.constraint(equalTo: repoByLabel.bottomAnchor, constant: 4),
            repoAuthorNameLabel.leadingAnchor.constraint(equalTo: repoByLabel.leadingAnchor),
            repoAuthorNameLabel.trailingAnchor.constraint(equalTo: repoByLabel.trailingAnchor)
        ])
    }
    
    private func setupStarsStackView() {
        view.addSubview(starsStackView)
        starsStackView.translatesAutoresizingMaskIntoConstraints = false
        starsStackView.axis = .horizontal
        starsStackView.alignment = .center
        starsStackView.spacing = 3
        
        starsStackView.addArrangedSubview(starIconImageView)
        starsStackView.addArrangedSubview(starsNumberLabel)
        
        NSLayoutConstraint.activate([
            starsStackView.topAnchor.constraint(equalTo: repoAuthorNameLabel.bottomAnchor, constant: 6),
            starsStackView.leadingAnchor.constraint(equalTo: repoAuthorNameLabel.leadingAnchor),
            starsStackView.trailingAnchor.constraint(equalTo: repoAuthorNameLabel.trailingAnchor),
            
            starIconImageView.heightAnchor.constraint(equalToConstant: 13),
            starIconImageView.widthAnchor.constraint(equalToConstant: 13)
        ])
    }
    
    private func setupStarIconImageView() {
        starIconImageView = UIImageView(image: UIImage(named: "fullStarIcon.png"))
    }
    
    private func setupStarsNumberLabel() {
        starsNumberLabel.text = "Number of Stars ("
        if let stars = repoPreview?.numberOfStars {
            starsNumberLabel.text?.append(String(stars))
        }
        starsNumberLabel.text?.append(")")
        starsNumberLabel.font = UIFont.systemFont(ofSize: 13)
        starsNumberLabel.textColor = UIColor(white: 1, alpha: 0.5)
    }
    
    private func setupRepoTitleStackView() {
        view.addSubview(repoTitleStackView)
        repoTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        repoTitleStackView.axis = .horizontal
        repoTitleStackView.alignment = .center
        repoTitleStackView.distribution = .fillProportionally
        repoTitleStackView.contentMode = .scaleToFill
        
        repoTitleStackView.addArrangedSubview(repoTitleLabel)
        repoTitleStackView.addArrangedSubview(viewOnlineButton)
        
        NSLayoutConstraint.activate([
            repoTitleStackView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 17),
            repoTitleStackView.leadingAnchor.constraint(equalTo: starsStackView.leadingAnchor),
            repoTitleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: K.Margins.trailing),
            
            repoTitleLabel.leadingAnchor.constraint(equalTo: repoTitleStackView.leadingAnchor),
            
            viewOnlineButton.trailingAnchor.constraint(equalTo: repoTitleStackView.trailingAnchor),
            viewOnlineButton.widthAnchor.constraint(equalToConstant: 118)
        ])
    }
    
    private func setupRepoTitleLabel() {
        repoTitleLabel.text = repoPreview?.repoTitle
        repoTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    private func setupViewOnlineButton() {
        viewOnlineButton.setTitle("VIEW ONLINE", for: .normal)
        viewOnlineButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        viewOnlineButton.setTitleColor(.systemBlue, for: .normal)
        viewOnlineButton.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        viewOnlineButton.layer.cornerRadius = 17
        viewOnlineButton.addTarget(self, action: #selector(viewOnlinePressed), for: .touchUpInside)
    }
    
    private func setupCommitsHistoryLabel() {
        view.addSubview(commitsHistoryLabel)
        commitsHistoryLabel.translatesAutoresizingMaskIntoConstraints = false
        commitsHistoryLabel.text = "Commits History"
        commitsHistoryLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        NSLayoutConstraint.activate([
            commitsHistoryLabel.topAnchor.constraint(equalTo: repoTitleStackView.bottomAnchor, constant: 35),
            commitsHistoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.Margins.leading),
            commitsHistoryLabel.trailingAnchor.constraint(equalTo: repoTitleStackView.trailingAnchor)
        ])
    }
    
    private func setupCommitsTableView() {
        view.addSubview(commitsTableView)
        commitsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            commitsTableView.topAnchor.constraint(equalTo: commitsHistoryLabel.bottomAnchor, constant: 10),
            commitsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commitsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commitsTableView.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -24)
        ])
        
        commitsTableView.dataSource = self
        commitsTableView.delegate = self
        commitsTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: commitsTableView.frame.size.width, height: 1))
        commitsTableView.register(CommitsTableViewCell.self, forCellReuseIdentifier: "commitCell")
        commitsTableView.allowsSelection = false
    }
    
    private func setupShareButton() {
        view.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        shareButton.setTitle("Share Repo", for: .normal)
        shareButton.setImage(UIImage(named: "shareIcon.png"), for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        shareButton.setTitleColor(.systemBlue, for: .normal)
        shareButton.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        shareButton.layer.cornerRadius = 10
        shareButton.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
        shareButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        shareButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        
        NSLayoutConstraint.activate([
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.Margins.leading),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: K.Margins.trailing),
            shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.5)
    }
    
    // MARK: - Actions
    @objc private func viewOnlinePressed() {
        guard let safeString = repoPreview?.repoURL else { return }
        if let safeUrl = URL(string: safeString) {
            UIApplication.shared.open(safeUrl)
        }
    }
    
    @objc private func sharePressed() {
        if let title = repoPreview?.repoTitle, let url = repoPreview?.repoURL {
            coordinator?.share(repoName: title, repoURL: url)
        }
    }
}

// MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let commits = commitsPreviews else { return 0 }
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commitsTableView.dequeueReusableCell(withIdentifier: "commitCell") as! CommitsTableViewCell
        guard let commit = commitsPreviews?[indexPath.row] else {
            return CommitsTableViewCell()
        }
        cell.populateCell(authorName: commit.authorName, authorEmailAddress: commit.authorEmailAddress, commitMessage: commit.commitMessage, commitNumber: indexPath.row + 1)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        activityIndicator.stopAnimating()
    }
}

// MARK: - ServiceManagerDelegate
extension DetailsViewController: CommitsDetailsDelegate {
    func commitsDetailsLoaded(commits: [CommitPreview]) {
        commitsPreviews = commits
        commitsTableView.reloadData()
    }
}
