//
//  UserTableViewCell.swift
//  TestTask
//
//  Created by Macintosh on 20/12/2019.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    weak var viewModel: UserTableViewCellViewModel? {
        didSet {
            configure()
        }
    }
}

private extension UserTableViewCell {
    func configure() {
        self.nameLabel.text = self.viewModel?.name
        self.idLabel.text = self.viewModel?.id
    }
}
