//
//  SceneDelegate.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/02.
//

import UIKit
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
                       if (AuthApi.isKakaoTalkLoginUrl(url)) {
                           _ = AuthController.handleOpenUrl(url: url)
                       }
                   }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene

        let token = KeyChain().read(key: "token")
        if(token == nil){
            // 토큰이 없는 경우
            // 로그인 페이지로
            let mainStoryboard = UIStoryboard(name: "LoginPage", bundle: nil)
            let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")

             window?.rootViewController = mainViewController
             window?.makeKeyAndVisible()


        }else{
            // 토큰이 있는 경우
            // 유저 정보 요청
            LoginAPI.shared.getUser{
                (networkResult) in
                switch networkResult{
                case .success(let data):
                    let user : User = data as! User
                    UserManager.shared.setUser(user)

                    // 메인 페이지로
                    let mainStoryboard = UIStoryboard(name: "MapView", bundle: nil)
                    let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MapNavigationViewController")

                    self.window?.rootViewController = mainViewController
                    self.window?.makeKeyAndVisible()

                case .requestErr(let msg):
                    if let message = msg as? String {
                        print(message)
                    }
                case .pathErr:
                    print("pathErr in getUser")
                case .serverErr:
                    print("serverErr in getUser")
                case .networkFail:
                    let mainStoryboard = UIStoryboard(name: "LoginPage", bundle: nil)
                    let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")

                    self.window?.rootViewController = mainViewController
                    self.window?.makeKeyAndVisible()
                    print("networkFail in getUser")
                }
            }
        }
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func changeRootViewController (_ vc: UIViewController, animated: Bool) {
        guard let window = self.window else { return }
        window.rootViewController = vc // 전환
        
        UIView.transition(with: window, duration: 0.2, options: [.transitionCrossDissolve], animations: nil, completion: nil)
       
    }


}

