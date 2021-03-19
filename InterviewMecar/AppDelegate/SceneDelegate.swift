//
//  SceneDelegate.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/19/21.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        FirebaseApp.configure()
        
        let window = UIWindow.init(windowScene: scene)
        window.overrideUserInterfaceStyle = .light
        // TODO: Check state login to set rootview
        window.rootViewController = IntoduceViewController(nibName: "IntoduceViewController", bundle: nil)
        self.window = window
        window.makeKeyAndVisible()
    }
    
    private func createTabbarController() -> UITabBarController{
        let tabbar = UITabBarController()
        tabbar.viewControllers = [createHomeNC(), createSearchNC(), createAddPhotoNC(), createMessageNC(), createProfileNC()]
        UITabBar.appearance().tintColor = .black

        return tabbar
    }
    
    private func createHomeNC() -> UINavigationController {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let homeNC = UINavigationController(rootViewController: homeVC)
        return homeNC
    }
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let searchNC = UINavigationController(rootViewController: searchVC)
        return searchNC
    }
    
    private func createAddPhotoNC() -> UINavigationController {
        let addPhotoVC = AddPhotoViewController(nibName: "AddPhotoViewController", bundle: nil)
        let addPhotoNC = UINavigationController(rootViewController: addPhotoVC)
        return addPhotoNC
    }
    
    private func createMessageNC() -> UINavigationController {
        let messageVC = MessageViewController(nibName: "MessageViewController", bundle: nil)
        let messageNC = UINavigationController(rootViewController: messageVC)
        return messageNC
    }
    
    private func createProfileNC() -> UINavigationController {
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let profileNC = UINavigationController(rootViewController: profileVC)
        return profileNC
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

