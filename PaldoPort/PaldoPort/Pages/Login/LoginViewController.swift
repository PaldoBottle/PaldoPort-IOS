
import UIKit
import RxSwift
import KakaoSDKUser
import RxKakaoSDKUser
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleSignInButton.style = .wide
    
    }
    
    @IBAction func onTapGoogleLogin(_ sender: Any) {
        viewModel.loginWithGoogle()
        
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
                   LoginAPI.shared.loginWithGoogle(token: idToken!.tokenString).subscribe(onNext: {
                            (user) in
                        self.goToMapView()
                        },onError: {
                            (error) in
                            self.showAlert()
                            print(error)
                        }
                    ).disposed(by: self.disposeBag)
            }
        }
        

    }
        
    
    @IBAction func onTapKakaoLogin(_ sender: Any) {

        // 카카오톡으로 로그인일때
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext:{ (oauthToken) in
                    print("loginWithKakaoTalk success.")
                    LoginAPI.shared.loginWithKaKao(token: oauthToken.accessToken).subscribe(onNext: {
                            (user) in
                        self.goToMapView()
                        },onError: {
                            (error) in
                            print(error)
                        }
                    ).disposed(by: self.disposeBag)
                    
                }, onError: {error in
                    print(error)
                    self.showAlert()
                })
            .disposed(by: disposeBag)
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
