//
//  RevealViewController.swift
//  SideBar2
//
//  Created by 정기욱 on 18/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit

class RevealViewController: UIViewController {

    var contentVC: UIViewController? // 콘텐츠를 담당할 뷰 컨트롤러
    var sideVC: UIViewController? // 사이드 바 메뉴를 담당할 뷰 컨트롤러
    
    var isSideBarShowing = false // 현재 사이드 바가 열려있는지 여부
    
    let SLIDE_TIME = 0.3 // 사이드 바가 열리고 닫히는데 걸리는 시간
    let SIDEBAR_WIDTH: CGFloat = 260 // 사이드 바가 열릴 너비
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    // 초기 화면을 설정한다.
    func setupView() {
        // 1. _프론트 컨트롤러 객체를 읽어온다.
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
            // 2. 읽어온 컨트롤러를 클래스 전체에서 참조 할 수 있도록 멤버 변수로 선언된 contentVC에 저장한다.
            self.contentVC = vc
            
            // 3. _프론트 컨트롤러 객체를 메인 컨트롤러의 자식으로 등록한다.
            self.addChild(vc) // _프론트 컨트롤러를 메인 컨트롤러의 자식 뷰 컨트롤러로 등록
            self.view.addSubview(vc.view) // _프론트 컨트롤러의 뷰를 메인 컨트롤러의 서브 뷰로 등록
            
            // _프론트 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 알려준다.
            vc.didMove(toParent: self)
            
        }
    }
    
    // 사이드 바의 뷰를 읽어온다.
    func getSideView() {
        if self.sideVC == nil {
            // 1. 사이드 바 컨트롤러 객체를 읽어온다.
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear"){
                // 2. 다른 메소드에서도 참조할 수 있도록 sideVC 속성에 저장한다. 즉 클래스 멤버변수에 넣음
                self.sideVC = vc
                
                // 3. 읽어온 사이드 바 컨트롤러 객체를 컨테이너 뷰 컨트롤러에 연결한다.
                self.addChild(vc)
                self.view.addSubview(vc.view)
                
                //4. _프론트 컨트롤러에 뷰 컨트롤러가 바뀌었음을 알려준다.
                vc.didMove(toParent: self)
                
                // 5. _프론트 컨트롤러의 뷰를 제일 위로 올린다.
                self.view.bringSubviewToFront((self.contentVC?.view)!)
            }
        }
    }
    
    // 콘텐츠 뷰에 그림자 효과를 준다.
    func setShadowEffect(shadow: Bool, offset: CGFloat){
        if (shadow == true) {
            // 그림자 효과 설정
            self.contentVC?.view.layer.cornerRadius = 10 // 그림자 모서리 둥글기
            self.contentVC?.view.layer.shadowOpacity = 0.8 // 그림자 투명도
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset) // 그림자 크기
        } else {
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
        
    }
    
    // 사이드 바를 연다.
    func openSideBar(_ complete: ( () -> Void)?){
        // 1. 앞에서 정의했던 메소드들을 실행
        self.getSideView() // 사이드 바 뷰를 읽어온다.
        self.setShadowEffect(shadow: true, offset: -2) // 그림자 효과를 준다.
        
        // 2. 애니메이션 옵션 실행
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        // curveEaseInOut은 애니메이션 구간별 속도 옵션 ( 처음과 끝은 점점 느리게 중간은 점점 빠르게 움직이도록)
        // beginFromCurrentState는 현재 다른 애니메이션이 진행 중일지라도 지금 상태에서 바로 진행하라는 의미
        
        // 3. 애니메이션 실행
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), // 애니메이션 실행 시간(초)
                       delay: TimeInterval(0), // 애니메이션 실행 전에 대기할 시간(초)
                       options: options, // 애니메이션 실행 옵션
                       animations: { // 실행할 애니메이션 내용 (0,0)을 기준점으로 하여
                        // 화면 전체를 차지하고 있던 콘텐츠 뷰의 위치를 일정 크기 만큼 옆으로 옮기는 것
                        self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)},
                    
            // 애니메이션 종료 후 실행해야 할 구문을 함수나 클로저 형태로 입력받는 역할
            // 애니메이션은 비동기로 실행되기 떄문에 애니메이션이 완료되는 시점을 특정하기 어렵다
            // 그래서 마지막 매개변수 completion이 필요하다.
            // completion 매개변수에 입력된 함수는 애니메이션이 완료 된 후에 호출되도록 시스템적으로 보장됨
            // 따라서 애니메이션이 끝난 후 실행해야할 코드를 넣어주면됨.
            // 이때 completion에 들어갈 함수구문은 반드시 Bool 형태의 매개변수로 들어가야함.
            // 해당 함수를 호출할 때 애니메이션의 실행 완료 여부를 여기에 넣어 전달하기 떄문
            // $0 == ture라면 --> 애니메이션이 정상적으로 종료됐다면,
            // 사이드바가 열려있다고 플래그를 변경한다.
            // 마지막으로 complete() 메소드를 호출해 주는데
            // openSideBar(_:) 호출 시 인자값으로 입력된 함수이다.
            // 애니메이션이 완료된후 completion 블록에서 호출되는 동적함수이고
            // 만약 완료 후 실행할 내용이 없다면 nil값을 반환함.
                    completion: { // 애니메이션 완료 후 실행해야 할 내용
                        if $0 == true {
                        self.isSideBarShowing = true // 열림 상태로 플래그를 변경한다.
                        complete?()
                        }
        }
        )
    }
    
    // 사이드 바를 닫는다.
    func closeSideBar(_ complete: ( () -> Void)?){
        
    }
    
}
