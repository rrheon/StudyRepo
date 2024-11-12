//
//  UIView+Ext.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/11/24.
//

import UIKit

extension UIView {
  
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
