//
//  SegmentController.swift
//  CustomSegmentControl
//
//  Created by 이명직 on 2021/08/03.
//

import Foundation
import UIKit

// 이 클래스에서만 사용할 수 있도록 설정
protocol CustomSegmentControlDelegate:class {
    func segmentValueChanged(to index: Int)
}

class CustomSegmentController: UIView {
    private var buttonTitles: [String]!
    private var buttons: [UIButton]!
    var textColor: UIColor = .black
    var selectedColor: UIColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    
    // 가져올 수는 있으나 외부에서는 값을 변경할 수 없음
    public private(set) var selectedIndex: Int = 0
    
    weak var segmentDelegate: CustomSegmentControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 기본적인 뷰 설정
    }
    
    // 데이터를 뷰에 적용할 때
    convenience init(frame: CGRect, buttonTitles: [String]) {
        self.init(frame: frame)
        print("CustomSegment - convenience init() called")
        self.buttonTitles = buttonTitles
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
        print("CustomSegment - draw() called")
    }
    
    fileprivate func updateView() {
        print("CustomSegment - updateView() called")
        createButton()
        configStackView()
    }
    
    fileprivate func createButton() {
        print("CustomSegment - createButton() called")
        self.buttons = [UIButton]()
        // 기존 버튼 모두 제거
        self.buttons.removeAll()
        // 하위 뷰들을 모두 제거
        subviews.forEach({$0.removeFromSuperview()})
        
        // 새로 만든 버튼들을 넣어줌
        for btnTitleItem in buttonTitles {
            let button = UIButton(type: .system)
            button.backgroundColor = .white
            button.titleLabel?.textColor = .black
            button.layer.borderWidth = 1
            button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            button.backgroundColor = .white
            button.layer.cornerRadius = 10
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.setTitle(btnTitleItem, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            // 글자가 현재 글자의 50%까지 축소됨 (크기에 맞춰서)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.minimumScaleFactor = 0.5
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(CustomSegmentController.buttonAction(_:)), for: .touchUpInside)
            
            self.buttons.append(button)
        }
        // 선택된 버튼 설정
        buttons[0].setTitleColor(.white, for: .normal)
        buttons[0].backgroundColor = selectedColor
        
    }
    
    fileprivate func configStackView() {
        print("CustomSegment - configStackView() called")
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    // 세그먼트 버튼 클릭 시
    @objc func buttonAction(_ sender: UIButton) {
        for(buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                selectedIndex = buttonIndex
                // 델리게이트 패턴으로 클릭된 버튼 인덱스 알려주기
                segmentDelegate?.segmentValueChanged(to: self.selectedIndex)
                btn.backgroundColor = selectedColor
                btn.setTitleColor(.white, for: .normal)
            }
            else {
                btn.backgroundColor = .white
                btn.setTitleColor(textColor, for: .normal)
            }
        }
        print("CustomSegment - buttonAction() called / selectedIndex: \(selectedIndex)")
    }
}

#if DEBUG
import SwiftUI
struct CustomViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
    }
    @available(iOS 13.0.0, *)
    struct MyTestViewControllerPreviewProvider: PreviewProvider {
        static var previews: some View {
            Group {
                CustomViewControllerRepresentable().previewDisplayName("").previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
            }
        }
    }
}
#endif
