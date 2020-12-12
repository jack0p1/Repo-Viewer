//
//  CommitsTableViewCell.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 13/12/2020.
//

import UIKit

class CommitsTableViewCell: UITableViewCell {

    // MARK: - Properties
    
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
        
    }
    
    func populateCell() {
        
    }
    
}
