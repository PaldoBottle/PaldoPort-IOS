//
//  MenuModalViewController.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/07.
//

import UIKit
import Kingfisher


class MenuModalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let data = ["내 스탬프", "챌린지"]
    var gotoStampPage: (() -> Void)?
    var gotoChallengePage : (() -> Void)?
    
    var menuView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.modalPresentationStyle = .pageSheet
        
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 50, width: 140, height: 140))
        
        let user : User = UserManager.shared.getUser()!
        
        let url = URL(string: user.profileImg!)
        imageView.kf.setImage(with:url)
        
        imageView.layer.cornerRadius = imageView.frame.height/2
//        imageView.image = UIImage(named: "paldoPort")
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.center.x = view.center.x
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true

            self.view.addSubview(imageView)
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.maxY + 10, width: view.frame.width, height: 30))
        nameLabel.text = user.id
        nameLabel.textAlignment = .center

        let dateLabel = UILabel(frame: CGRect(x: 0, y: nameLabel.frame.maxY + 5, width: view.frame.width, height: 20))
        dateLabel.text = "내 포인트 : \(user.point!)P"
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor.gray

        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        
        self.menuView = UITableView(frame: CGRect(
            x: 0, y:dateLabel.frame.maxY + 2, width: self.view.bounds.width,
            height: self.view.bounds.height
        ))
        
        self.menuView.dataSource = self
        self.menuView.delegate = self
        
        self.menuView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let topPadding: CGFloat = 20.0
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

        let mapPageStoryboard : UIStoryboard = UIStoryboard(name: "MapView", bundle: nil)

        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            self.dismiss(animated: true)
            self.gotoStampPage!()
        case 1:
            self.dismiss(animated: true)
            self.gotoChallengePage!()
        default:
            return
        }

    }
}
