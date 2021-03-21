//
//  ProfileViewController.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

enum ListProfileCell: String, CaseIterable {
    case signOut = "Sign out"
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var tbvProfile: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configureView() {
        tbvProfile.delegate = self
        tbvProfile.dataSource = self
        tbvProfile.tableFooterView = UIView()
        tbvProfile.register(UINib(nibName: TableviewCellName.profile, bundle: nil), forCellReuseIdentifier: TableviewCellName.profile)
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListProfileCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableviewCellName.profile, for: indexPath) as? ProfileTableviewCell else {
            return UITableViewCell()
        }
        cell.configureCell(style: ListProfileCell.allCases[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let style = ListProfileCell.allCases[indexPath.row]
        switch style {
        case .signOut:
            FirebaseManager.auth.signOut { [weak self] (success, error) in
                guard let strongSelf = self else {
                    return
                }
                if success {
                    if let sceneDelegate = strongSelf.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.handleLogout()
                    }
                } else {
                    strongSelf.showAlert(title: "", message: error?.localizedDescription ?? "")
                }
            }
        }
    }
    
}
