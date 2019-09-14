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
}

class DemoViewController: UIViewController {
    
    @IBOutlet weak var demoTableView: UITableView!
    
    var demos: [Demo] = [
        Demo(title: "UIPageViewController", bgImage: UIImage(named: "iphone-11")!),
        Demo(title: "UICollectionViewController", bgImage: UIImage(named: "Apple-Watch")!)
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
        return 130
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DemoCaseCell.swiftIdentifier, for: indexPath) as? DemoCaseCell else {
            return UITableViewCell()
        }
        
        cell.titleView.text = demos[indexPath.row].title
        cell.titleView.textColor = UIColor.white
        cell.titleView.font = cell.titleView.font.withSize(25)
        cell.bgImageView.image = demos[indexPath.row].bgImage
        cell.bgImageView.contentMode = .scaleAspectFill
        return cell
    }
}
