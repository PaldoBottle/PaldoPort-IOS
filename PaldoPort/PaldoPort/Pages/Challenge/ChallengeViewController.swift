
import UIKit
import RxSwift
import KakaoSDKUser
import RxKakaoSDKUser
import GoogleSignIn

class ChallengeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var challengeList : [Challenge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        getChallengeList()
    
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "로그인할 수 없음", message: "계정을 읽는데 실패하였습니다.", preferredStyle: .alert )
        let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
    }
    
    func getChallengeList(){
        ChallengeAPI.shared.getAllChallengeList{
            (networkResult) in
            switch networkResult{
            case .success(let data):
                let challenges : [Challenge] = data as! [Challenge]
              
                DispatchQueue.main.async {
                    self.challengeList = challenges
                }

            case .requestErr(let msg):
            if let message = msg as? String {
                print(message)
            }
            case .pathErr:
                print("pathErr in getRegionDetail")
            case .serverErr:
                print("serverErr in getRegionDetail")
            case .networkFail:
                print("networkFail in getRegionDetail")
            }
        }
        
    }
    
}

extension ChallengeViewController {
    // 콤포지셔널 레이아웃 설정
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        // 콤포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout{
            // 만들게 되면 튜플 (키: 값, 키: 값) 의 묶음으로 들어옴 반환 하는 것은 NSCollectionLayoutSection 콜렉션 레이아웃 섹션을 반환해야함
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈 - absolute 는 고정값, estimated 는 추측, fraction 퍼센트
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            // 위에서 만든 아이템 사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 아이템 간의 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            // 변경할 부분
            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/2)
            
            // 그룹사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            
            // 그룹사이즈로 그룹 만들기
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitems: [item, item, item])
            
            // 변경할 부분
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
            
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }
}

extension ChallengeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.challengeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cellId = String(describing: ChallengeCollectionViewCell.self)
        
                // 쎌의 인스턴스
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChallengeCollectionViewCell

                // 라벨 설정
                cell.name.text = challengeList[indexPath.item].name
                cell.desc.text = challengeList[indexPath.item].description
                cell.point.text = "포인트 : \(challengeList[indexPath.item].point)P"
        
                cell.contentView.layer.cornerRadius = 8
                cell.contentView.layer.borderWidth = 1
                cell.contentView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                
                return cell
    }
    
    
}

extension ChallengeViewController : UICollectionViewDelegate {
    
}
