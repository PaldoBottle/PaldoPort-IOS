
import UIKit
import KakaoSDKUser
import RxKakaoSDKUser
import GoogleSignIn
import Kingfisher

class MyStampViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var stampList : [Stamp] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView.collectionViewLayout = createCompositionalLayout()
        
        getStampList()
    }
    
//    @IBSegueAction func onTapStamp(_ coder: NSCoder) -> UIViewController? {
//        return StampDetailViewController()
//        
//    }
    func showAlert(){
        let alert = UIAlertController(title: "로그인할 수 없음", message: "계정을 읽는데 실패하였습니다.", preferredStyle: .alert )
        let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
    }
    
    func getStampList(){
        StampAPI.shared.getAllStamp{
            (networkResult) in
            switch networkResult{
            case .success(let data):
                let stamps : [Stamp] = data as! [Stamp]
              
                DispatchQueue.main.async {
                    self.stampList = stamps
                    self.collectionView.reloadData()
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

extension MyStampViewController {
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
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 20, trailing: 2)
            
            // 변경할 부분
            let groupHeight =  NSCollectionLayoutDimension.fractionalWidth(1/2)
            
            // 그룹사이즈
            let grouSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            
            // 그룹사이즈로 그룹 만들기
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitems: [item, item, item])
            
            // 변경할 부분
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: grouSize, subitem: item, count: 1)
            
            // 그룹으로 섹션 만들기
            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .groupPaging
            
            // 섹션에 대한 간격 설정
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }
}

extension MyStampViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stampList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cellId = String(describing: MyCollectionViewCell.self)
                
                // 쎌의 인스턴스
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MyCollectionViewCell
                let url = URL(string: stampList[indexPath.item].imageUrl)
        
                let processor = RoundCornerImageProcessor(cornerRadius: cell.contentView.frame.height)
                cell.imageView.kf.setImage(with:url, options: [.processor(processor)])
                // 라벨 설정
                cell.name.text = stampList[indexPath.item].district
                cell.district.text = stampList[indexPath.item].supDistrict
        
                cell.contentView.layer.cornerRadius = 8
                cell.contentView.layer.borderWidth = 1
                cell.contentView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
                cell.imageView.layer.cornerRadius = cell.imageView.frame.width/2
                   // 뷰의 경계에 맞춰준다
                cell.imageView.clipsToBounds = true
                
                return cell
    }
    
    
}

extension MyStampViewController : UICollectionViewDelegate {
    
}
