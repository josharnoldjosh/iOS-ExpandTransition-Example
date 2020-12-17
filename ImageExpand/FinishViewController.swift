//
//  FinishViewController.swift
//  ImageExpand
//
//  Created by Josh Arnold on 12/15/20.
//

import Foundation
import UIKit


class FinishViewController: UIViewController, ExpandTransitionDriver {

    
    private var imageView = UIImageView()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    func setupImageView() {
        imageView.image = UIImage(named: "Art")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 0
        imageView.clipsToBounds = true
        imageView.frame = view.frame
        imageView.layer.cornerRadius = 12
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func getImageView() -> UIImageView {
        return self.imageView
    }
}
