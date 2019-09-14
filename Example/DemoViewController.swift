//
//  DemoViewController.swift
//  Example
//
//  Created by tskim on 14/09/2019.
//  Copyright © 2019 Tyler. All rights reserved.
//

import UIKit

struct Demo {
    let title: String
    let bgImage: UIImage
    let isReady: Bool
    let soon: String = "Soon"
}

class DemoViewController: UIViewController {
    
    @IBOutlet weak var demoTableView: UITableView!
    
    var demos: [Demo] = [
        Demo(title: "UIPageViewController", bgImage: UIImage(named: "iphone-11")!, isReady: true),
        Demo(title: "UICollectionViewController", bgImage: UIImage(named: "Apple-Watch")!, isReady: true),
        Demo(title: "Rx+UIPageViewController", bgImage: UIImage(named: "induction-edition")!, isReady: false),
        Demo(title: "Rx+UICollectionViewController", bgImage: UIImage(named: "iPhone-11-2")!, isReady: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoTableView.register(DemoCaseCell.nib, forCellReuseIdentifier: DemoCaseCell.swiftIdentifier)
        demoTableView.delegate = self
        demoTableView.dataSource = self
        demoTableView.separatorStyle = .none
    }
}

extension DemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            self.show(UIPageViewControllerExample.initFromStoryboard(), sender: self)
        case 1:
            self.show(UICollectionViewControllerExample.initFromStoryboard(), sender: self)
        default:
            break
        }
    }
}

extension DemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DemoCaseCell.swiftIdentifier, for: indexPath) as? DemoCaseCell else {
            return UITableViewCell()
        }
        let item = demos[indexPath.row]
        cell.titleView.text = item.title
        cell.titleView.textColor = UIColor.white
        cell.titleView.font = cell.titleView.font.withSize(25)
        cell.bgImageView.image = item.bgImage
        cell.bgImageView.contentMode = .scaleAspectFill
        if !item.isReady {
            cell.bgImageView.blurView.setup(style: .dark, alpha: 0.9).enable()
            cell.soon.text = item.soon
            cell.titleView.textColor = UIColor.darkGray
            cell.soon.textColor = UIColor.white
            cell.soon.font = cell.titleView.font.withSize(30)
        }
        return cell
    }
}
