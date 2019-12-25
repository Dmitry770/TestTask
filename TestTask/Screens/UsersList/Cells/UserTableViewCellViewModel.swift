//
//  UserTableViewCellViewModel.swift
//  TestTask
//
//  Created by Macintosh on 20/12/2019.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import Foundation

class UserTableViewCellViewModel {
    var name: String
    var id: String
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
}
