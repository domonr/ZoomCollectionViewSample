//
//  ViewController.swift
//  VerticalZoomSample
//
//  Created by Domon on 2019/11/20.
//  Copyright © 2019 Domon. All rights reserved.
//

import UIKit

class VerticalViewController: UIViewController {
    
    @IBOutlet weak var viewerView: VerticalViewerView!
    
    private var isStatusBarHidden: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    
    override var shouldAutorotate: Bool {
        // まあでもデフォルトでtrue返すっぽいし、overrideしなくていいっぽい
        return true
    }

    // ここでサポートできるOrientationを明示できる
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewerView.setData(self.generateData())
    }
    
    private func generateData() -> [(String, CGSize)] {
        return [
            ("https://affi-drifter.com/wp-content/uploads/2018/05/20170828180155-320x186.jpg", CGSize(width: 320, height: 186)),
            ("https://affi-drifter.com/wp-content/uploads/2018/05/20170828180155-320x186.jpg", CGSize(width: 320, height: 186)),
            ("https://grapee.jp/wp-content/uploads/57507_01.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_02.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_03.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_04.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_01.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_02.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_03.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_04.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_01.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_02.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_03.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_04.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_01.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_02.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_03.jpg", CGSize(width: 710, height: 1_006)),
            ("https://grapee.jp/wp-content/uploads/57507_04.jpg", CGSize(width: 710, height: 1_006)),
        ]
    }
    
    private func generateAdView() -> UIView {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }
}
