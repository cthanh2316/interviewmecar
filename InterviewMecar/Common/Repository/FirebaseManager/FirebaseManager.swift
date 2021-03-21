//
//  FirebaseManager.swift
//  InterviewMecar
//
//  Created by Cong Thanh on 3/21/21.
//

import Firebase

class FirebaseManager {
    
    static let auth = FirebaseAuthManager()
    
}

class FirebaseAuthManager {
    
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ user: User?, _ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                completionBlock(true, user, nil)
            } else {
                completionBlock(false, nil, error)
            }
        }
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false, error)
            } else {
                completionBlock(true, nil)
            }
        }
    }
    
    func signOut(completionBlock: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completionBlock(true, nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            completionBlock(false, signOutError)
        }
    }
}
