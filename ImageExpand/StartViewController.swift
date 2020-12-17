//
//  ViewController.swift
//  ImageExpand
//
//  Created by Josh Arnold on 12/15/20.
//

import UIKit
import SnapKit
import Closures


class StartViewController: UIViewController, ExpandTransitionDriver {
    
    
    private var imageView = UIImageView()
    private var transition:ExpandTransition!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupImageView()
        handleTap()
    }
    
    func handleTap() {
        imageView.addTapGesture { (tap) in
            let vc = FinishViewController()
            vc.modalPresentationStyle = .custom
            self.transition = ExpandTransition(start: self, finish: vc, duration: 0.7)
            vc.transitioningDelegate = self.transition
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func setupImageView() {
        imageView.image = UIImage(named: "Art")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
            make.width.equalTo(150)
            make.center.equalToSuperview()
        }
    }
    
    func getImageView() -> UIImageView {
        return self.imageView
    }
}

