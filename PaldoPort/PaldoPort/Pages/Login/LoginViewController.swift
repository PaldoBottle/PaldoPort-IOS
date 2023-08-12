
import UIKit
import RxSwift
import KakaoSDKUser
import RxKakaoSDKUser

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func onTapNaverLogin(_ sender: Any) {
        viewModel.loginWithNaver()
        goToMapView()
    }
    
    
    @IBAction func onTapGoogleLogin(_ sender: Any) {
        viewModel.loginWithGoogle()
        
        goToMapView()
    }
    
    
    @IBAction func onTapKakaoLogin(_ sender: Any) {
        viewModel.loginWithKaKao()
        
        // 카카오톡으로 로그인일때
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext:{ (oauthToken) in
                    print("loginWithKakaoTalk success.")
                    LoginAPI.loginWithSocial(token: oauthToken.accessToken).subscribe(onNext: {
                            (user) in
                        self.goToMapView()
                        },onError: {
                            (error) in
                            print(error)
                        }
                    ).disposed(by: self.disposeBag)
                    
                }, onError: {error in
                    print(error)
                })
            .disposed(by: disposeBag)
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
    
}
