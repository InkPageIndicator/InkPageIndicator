//
//  ChildViewController.swift
//  Example
//
//  Created by tskim on 12/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit


public class ChildViewController: UIViewController {
    
    let imageView = UIImageView()
    var model: ChildModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = model.image
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
