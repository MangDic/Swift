//
//  ViewController.swift
//  CustomSegmentControl
//
//  Created by 이명직 on 2021/08/03.
//

import UIKit

class ViewController: UIViewController, CustomSegmentControlDelegate {
    @IBOutlet weak var whatDayTitle: UILabel!
    
    let myDayCharacterArray = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻"]
    var myDayArray = ["월","화","수","목","금","토", "일"]
    
    func segmentValueChanged(to index: Int) {
        print("ViewController - segmentValueChanged() called / index : \(index)")
        self.whatDayTitle.text = myDayArray[index] + "요일\n" + myDayCharacterArray[index]
    }
    

    override func loadView() {
        super.loadView()
        print("ViewController - loadView() called")
        let customSegmentControl = CustomSegmentController(frame: CGRect(x: 0, y: 0, width: 200, height: 200), buttonTitles: myDayArray)
        self.view.addSubview(customSegmentControl)
        
        customSegmentControl.segmentDelegate = self
        //customSegmentControl.backgroundColor = .red
        customSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        customSegmentControl.widthAnchor.constraint(equalToConstant: 300).isActive = true
        customSegmentControl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        customSegmentControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        customSegmentControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
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
                ViewControllerRepresentable().previewDisplayName("").previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
            }
        }
    }
}
#endif
