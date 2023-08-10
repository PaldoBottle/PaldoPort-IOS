//
//  MenuModalViewController.swift
//  PaldoPort
//
//  Created by seonwoo on 2023/08/07.
//

import UIKit


class MenuModalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let data = ["설정 및 개인정보", "내 스탬프", "저장됨", "로그아웃"]
    
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
        print("Selected: \(data[indexPath.row])")
    }
}
