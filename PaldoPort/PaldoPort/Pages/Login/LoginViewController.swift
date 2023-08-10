
import UIKit

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func onTapNaverLogin(_ sender: Any) {
        viewModel.loginWithNaver()
        goToMapView()
    }
    
    
    @IBAction func onTapAppleLogin(_ sender: Any) {
        viewModel.loginWithApple()
        goToMapView()
    }
    
    
    @IBAction func onTapKakaoLogin(_ sender: Any) {
        viewModel.loginWithKaKao()
        goToMapView()
    }
    
    // 로그인 성공하면 메인화면으로
    func goToMapView(){
        
        let mapVC =  UIStoryboard(name: "MapView", bundle: nil)
            .instantiateViewController(withIdentifier: "MapViewController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mapVC, animated: true)
        
    }
    
}
