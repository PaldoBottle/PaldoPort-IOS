//
//  MenuModalViewController.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/07.
//

import UIKit


class MenuModalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let data = ["설정 및 개인정보", "내 스탬프", "챌린지", "로그아웃"]
    
    var menuView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.modalPresentationStyle = .pageSheet
        
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        self.menuView = UITableView(frame: CGRect(
            x: 0, y:0, width: self.view.bounds.width,
            height: self.view.bounds.height
        ))
        
        self.menuView.dataSource = self
        self.menuView.delegate = self
        
        self.menuView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let topPadding: CGFloat = 40.0
              menuView.contentInset = UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0)

        self.view.addSubview(menuView)
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let loginPageStoryboard : UIStoryboard = UIStoryboard(name: "MapView", bundle: nil)

        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            break
        case 1:
            print("흠")
            if let targetViewController = storyboard?.instantiateViewController(withIdentifier: "MapNavigationViewController") {
                print("애초에 여길안오나?")
                if let navigationController = targetViewController.navigationController {
                    guard let viewController = UIStoryboard(name: "MyStamp", bundle: nil).instantiateViewController(identifier: "MyStampViewController") as? MyStampViewController else {return}
                    navigationController.pushViewController(viewController, animated: true)
                }
                print("여기까지 안오나")
            }
            self.dismiss(animated: true)
        case 2:
            guard let viewController = UIStoryboard(name: "Challenge", bundle: nil).instantiateViewController(identifier: "ChallengeViewController") as? ChallengeViewController else {return}
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }

    }
}
