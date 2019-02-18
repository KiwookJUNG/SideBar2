//
//  SideBarViewController.swift
//  SideBar2
//
//  Created by 정기욱 on 18/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit

class SideBarViewController: UITableViewController{
    
    // 메뉴 제목 배열
    let titles = [
    "메뉴 01",
    "메뉴 02",
    "메뉴 03",
    "메뉴 04",
    "메뉴 05"
    ]
    
    // 메뉴 아이콘 배열
    let icons = [
    UIImage(named: "icon01.png"),
    UIImage(named: "icon02.png"),
    UIImage(named: "icon03.png"),
    UIImage(named: "icon04.png"),
    UIImage(named: "icon05.png")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
        // 테이블 목록의 크기를 배열 데이터의 크기에 동적으로 연동
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재사용 큐로부터 테이블 셀을 꺼내 온다.
         let id = "menucell" // 재사용 큐에 등록할 식별자
        
        //// var cell = tableView.dequeueReusableCell(withIdentifier: id)
        
        //// 재사용 큐에 menucell키로 등록된 테이블 뷰 셀이 없다면 새로 추가한다.
        //// if cell == nil {
        //// cell = UITableViewCell(style: .default, reuseIdentifier: id) }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)  // 다음과 같이 병합연산자를 사용해 표현할수도 있음.
        
        // 위와 같이 표현 할 수 있지만 재사용 큐를 사용할 필요가 없다면
        
        // 재사용 큐 대신 셀을 새로 생성한다.
        // let cell = UITableViewCell()
        
        // 재사용 큐 없이 직접 테이블 뷰를 생성하는것은 화면에 한번에 표현할 수 있는 셀이 있을때만 사용해야함
        
        // 타이틀과 이미지를 대입한다.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // 폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
        
    }
}
