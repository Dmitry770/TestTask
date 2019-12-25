//
//  UsersListViewController.swift
//  TestTask
//
//  Created by Macintosh on 20/12/2019.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
     var selectIndexPath:IndexPath?
   
    
    var viewModel: UsersListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        self.viewModel = UsersListViewModel(delegate: self)
        self.viewModel?.getUsersList()
    }
}

extension UsersListViewController: UsersListViewModelDelegate {
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func showError(error: String) {
        showAlert(title: error, message: nil, nil)
    }
    
}

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = self.viewModel?.viewModelForCell(index: indexPath.row)
        
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.allowsEditing = false
            selectIndexPath = indexPath
            present(picker, animated: true)
        } else {
            showError(error: "Can't find camera")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        var image = UIImage()
        image = chosenImage
       
        if let indexPath = selectIndexPath {
            APIManager.shared.postContent(content: (viewModel?.getContent(for: indexPath.row))!, image: image )
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.cellHight() ?? 44
    }
    
}

private extension UsersListViewController {
    
    func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "UserTableViewCell")
    }
    
}


