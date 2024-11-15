//
//  UIView+Ext.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/11/24.
//

import UIKit

extension UIView {
  
  /// 테두리 두께 설정
  @IBInspectable var borderWidth: CGFloat {
    set {
      layer.borderWidth = newValue
    }
    get {
      return layer.borderWidth
    }
  }
  
  
  /// conerRadius 설정
  @IBInspectable var cornerRadius: CGFloat {
    set {
      layer.cornerRadius = newValue
    }
    get {
      return layer.cornerRadius
    }
  }
  
  /// 테두리 색상 설정
  @IBInspectable var borderColor: UIColor? {
    set {
      guard let uiColor = newValue else { return }
      layer.borderColor = uiColor.cgColor
    }
    get {
      guard let color = layer.borderColor else { return nil }
      return UIColor(cgColor: color)
    }
  }

  /// customView 제약 적용
  /// - Parameter nibName: 사용할 nibName( nil이면 파일명사용 )
  func applyNib(nibName: String? = nil){
    let _nibName = nibName == nil ? String(describing: Self.self) : nibName
   
    let nib = Bundle.main.loadNibNamed(_nibName ?? "", owner: self)
    guard let view = nib?.first as? UIView else { return }
    
    addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: self.topAnchor),
      view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }
  
}
