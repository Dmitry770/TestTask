//
//  UsersListViewModel.swift
//  TestTask
//
//  Created by Macintosh on 20/12/2019.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

protocol UsersListViewModelDelegate: class {
    func reloadData()
    func showError(error: String)
}

class UsersListViewModel {
    
    weak var delegate: UsersListViewModelDelegate?
    
    private var usersList = [Content]()
    
    init(delegate: UsersListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func getUsersList() {
        APIManager.shared.getContent { (usersList, error) in
            if let error = error {
                self.delegate?.showError(error: error)
            } else if let usersList = usersList {
                self.usersList = usersList
                self.delegate?.reloadData()
            }
        }
    }
    
    
    
    func numberOfRowsInSection() -> Int {
        return self.usersList.count
    }
    
    func viewModelForCell(index: Int) -> UserTableViewCellViewModel? {
        let name = self.usersList[index].name
        let id = self.usersList[index].id
        let viewModel = UserTableViewCellViewModel(name: name, id: "\(id)")
        return viewModel
    }
    func cellHight()->CGFloat {
        return 44
    }
    
    func getContent(for index:Int) -> Content {
        return usersList[index]
    }
}


