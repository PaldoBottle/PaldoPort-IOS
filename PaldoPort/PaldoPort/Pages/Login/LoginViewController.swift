
import UIKit
import RxSwift
import KakaoSDKUser
import RxKakaoSDKUser
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleSignInButton.style = .wide
    
    }
    
    @IBAction func onTapGoogleLogin(_ sender: Any) {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else {
                self.showAlert()
                return
            }
            guard let signInResult = signInResult else {
                self.showAlert()
                return
            }

            signInResult.user.refreshTokensIfNeeded { user, error in
                   guard error == nil else { return }
                   guard let user = user else { return }

                   let idToken = user.idToken
                LoginAPI.shared.loginWithGoogle(token: idToken!.tokenString){
                    (networkResult) in
                                    switch networkResult{
                                    case .success(let data):
                                        let user : User = data as! User
                                        self.goToMapView()

                                    case .requestErr(let msg):
                                        if let message = msg as? String {
                                            print(message)
                                        }
                                    case .pathErr:
                                        self.showAlert()
                                        print("pathErr in loginWithAPI")
                                    case .serverErr:
                                        self.showAlert()
                                        print("serverErr in loginWithAPI")
                                    case .networkFail:
                                        self.showAlert()
                                        print("networkFail in loginWithAPI")
                                    }
                }
            }
        }
        

    }
        
    
    @IBAction func onTapKakaoLogin(_ sender: Any) {

        // 카카오톡으로 로그인일때
        if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("loginWithKakaoTalk() success.")
                          
                            LoginAPI.shared.loginWithKaKao(token: oauthToken!.accessToken){
                                (networkResult) in
                                switch networkResult{
                                case .success(let data):
//                                    let tokens : [Token] = data as! [Token]
//
//                                    for token : Token in tokens {
//                                        KeyChain().create(key: token.types, token: token.token)
//                                    }
                                    
                                    self.goToMapView()

                                    
                                case .requestErr(let msg):
                                    if let message = msg as? String {
                                        print(message)
                                        self.showAlert()
                                    }
                                case .pathErr:
                                    print("pathErr in loginWithSocialAPI")
                                    self.showAlert()
                                case .serverErr:
                                    self.showAlert()
                                    print("serverErr in loginWithSocialAPI")
                                case .networkFail:
                                    self.showAlert()
                                    print("networkFail in loginWithSocialAPI")
                                }
                            }
                        }
                    }
                }else{
            showAlert()
        }
        
        // 카카오 계정으로 로그인
//        UserApi.shared.rx.loginWithKakaoAccount()
//            .subscribe(onNext:{ (oauthToken) in
//                print("loginWithKakaoAccount() success.")
//
//                //do something
//                _ = oauthToken
//            }, onError: {error in
//                print(error)
//            })
//            .disposed(by: disposeBag)


    }
    
    // 로그인 성공하면 메인화면으로
    func goToMapView(){
        
        let mapVC =  UIStoryboard(name: "MapView", bundle: nil)
            .instantiateViewController(withIdentifier: "MapViewController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mapVC, animated: true)
        
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "로그인할 수 없음", message: "계정을 읽는데 실패하였습니다.", preferredStyle: .alert )
        let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
    }
    
}
