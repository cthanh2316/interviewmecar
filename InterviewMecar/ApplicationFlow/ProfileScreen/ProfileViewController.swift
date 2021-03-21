//
//  ProfileViewController.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit

enum ListProfileCell: String, CaseIterable {
    case signOut = "Sign out"
    case changeLanguages = "Change languages"
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var tbvProfile: UITableView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
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
                
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadData),
            name: Notification.Name(NotificationName.changedLanguages),
            object: nil)
    }
    
    @objc private func reloadData() {
        self.tbvProfile.reloadData()
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
            self.showLoading()
            FirebaseManager.auth.signOut { [weak self] (success, error) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.hideLoading()
                if success {
                    if let sceneDelegate = strongSelf.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.handleLogout()
                    }
                } else {
                    strongSelf.showAlert(title: "", message: error?.localizedDescription ?? "")
                }
            }
        case .changeLanguages:
            if AppConfigure.currentLang == .vietnamese {
                AppConfigure.currentLang = .english
            } else {
                AppConfigure.currentLang = .vietnamese
            }
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(NotificationName.changedLanguages), object: nil)
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
