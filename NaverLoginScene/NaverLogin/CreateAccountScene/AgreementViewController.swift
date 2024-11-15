//
//  AgreementScene.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/14/24.
//

import UIKit

/// 서버에서 받을 동의항목 리스트
struct AgreementContentFromServer {
  var title: String
  var content: String
  var forKid: Bool = true
}

final class AgreementViewController: UIViewController {
  
  var isAllAgreementButtonTapped: Bool = false
  
  lazy var mockupContent: String = "목을 푸른 때, 어디에서 청춘이 꽃을 타는 같이 모든 위에 이름자를 농염한지 지나고 쓸쓸함과 좋은 닮은 왔을까? 다 불현듯 마른 것을 떨어진다. 라이너 우리를 아름따다 덧붙였다.까닭이요, 너를 켜지고 그 놓인 우리를 가득 북간도에 하염없이 역겨워 마음 빛은 건너온 보고 우리가 아직 생명들 있다. 날들을 둘로 실망하고 어디에서 이렇게 이름과, 고이 좋다.이름을 유유히 것이다​ 우리 걸리니 말 아름다웠고 고독은 고독은 거외다. 슬프게 흐른다 써 너무나 먼지와 추억도 동산에 흐르는 비로소 가난한 이 잠자야 모든 뚝떼어 쪽으로 입니다.언덕 너무나 쪽 목구멍을 목을 이름과, 약산 강이 같이 못한 없어지고 비로소 소학교 비로소 대지의 추운 올라와 함께 싣고 네가 봄이 한마디씩 날들을 타는 계십니다. 써요. 망각의 있으랴 알고 꽃이여 올라간다. 시인의 사랑했던 아무 평야에서 시와 이 번을 그대에게 내린 그 죽어 가느니 즈려 노루, 날에, 뿌리우리다. 아무 죽고 나와 저었습니다. 좋아요"
  
  lazy var agreementList: [AgreementContentFromServer] = [
    AgreementContentFromServer(title: "[필수] 네이버 이용약관", content: mockupContent),
    AgreementContentFromServer(title: "[필수] 개인정보 수집 및 이용", content: mockupContent, forKid: false),
    AgreementContentFromServer(title: "[선택] 실명 인증된 아이디로 가입", content: mockupContent),
    AgreementContentFromServer(title: "[선택] 위치기반서비스 이용약관", content: mockupContent),
    AgreementContentFromServer(title: "[선택] 개인정보 수집 및 이용", content: "")
  ]
  
  private lazy var agreementButtons: [AgreementComponent] = []
  
  private lazy var nextButton: NaverLoginButton = NaverLoginButton(title: "다음")
  
  @IBOutlet weak var agreementStackView: UIStackView!
  
  // 전체동의하기 버튼
  @IBOutlet weak var agreementAllButton1: UIButton!
  @IBOutlet weak var agreeAllButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    agreementAllButton1.tintColor = .gray

    settingAgreementButtons()
    settingBottomButtons()  
  }
  
  
  /// 각 동의 항목 버튼 UI세팅
  func settingAgreementButtons(){  
    agreementList.forEach { data in
      let agreementComponent: AgreementComponent = AgreementComponent(
        title: data.title,
        content: data.content,
        isHideForKidButton: data.forKid
      )
      
      // 버튼 관리를 위해 배열에 추가
      agreementButtons.append(agreementComponent)
      
      agreementComponent.translatesAutoresizingMaskIntoConstraints = false
      agreementStackView.addArrangedSubview(agreementComponent)
      
      // 맨 마지막 개인정보 수집 및 이용 항목은 스크롤뷰가 없어서 높이 조절
      let height: CGFloat = data.content.isEmpty == true ? 50 : 150
      NSLayoutConstraint.activate([
        agreementComponent.heightAnchor.constraint(equalToConstant: height)
      ])
      
      if data.content.isEmpty == true {
        agreementComponent.contentScrollView.isHidden = true

        let acceptEventView: AcceptEventComponent = AcceptEventComponent()
        agreementStackView.addArrangedSubview(acceptEventView)
        acceptEventView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          acceptEventView.heightAnchor.constraint(equalToConstant: 100)
        ])
      } else {
        // 스택뷰 요소 사이의 공간 조절
        let emptyView: UIView = UIView()
        
        agreementStackView.addArrangedSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
          emptyView.heightAnchor.constraint(equalToConstant: 20)
        ])
      }
    }
  }
  
  
  /// bottom 버튼 UI 설정
  func settingBottomButtons(){
    let bottomViewComponent: BottomViewComponent = BottomViewComponent()
    view.addSubview(bottomViewComponent)
    bottomViewComponent.translatesAutoresizingMaskIntoConstraints = false
    bottomViewComponent.backgroundColor = .lightGray
    NSLayoutConstraint.activate([
      bottomViewComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
      bottomViewComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
      bottomViewComponent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
    ])
    
    // 다음 버튼 UI설정
    self.view.addSubview(nextButton)

    nextButton.translatesAutoresizingMaskIntoConstraints = false
    nextButton.naverLoginButton.backgroundColor = .unActivateNextButtonColor
    nextButton.naverLoginButton.cornerRadius = 8
    nextButton.naverLoginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
    NSLayoutConstraint.activate([
      nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      nextButton.bottomAnchor.constraint(equalTo: bottomViewComponent.topAnchor, constant: -30),
      nextButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  
  /// 동의하기 버튼 터치
  /// - Parameter sender: 각 동의하기 항목들의 버튼
  @IBAction func agreeButtonTapped(_ sender: UIButton){
    isAllAgreementButtonTapped.toggle()
    
    let imageName: String = isAllAgreementButtonTapped ? "checkmark.circle.fill" : "checkmark.circle"
    
    self.agreementAllButton1.setImage(UIImage(systemName: imageName), for: .normal)
    self.agreementAllButton1.tintColor = isAllAgreementButtonTapped ? .activateButtonColor : .gray
    
    agreementButtons.forEach { agreementComponent in
      agreementComponent.allAgreementButtonTapped(allBtnSelected: isAllAgreementButtonTapped)
    }
  }
}
