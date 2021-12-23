//
//  LaunchViewController.swift
//  NY Articles
//
//  Created by Safe City Mac 001 on 22/12/2021.
//

import UIKit

class LaunchViewController: UIViewController {

    let launchVM = LaunchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.launchVM.ValidateApp()
    }
}

extension LaunchViewController{
    func bindViewModel(){
        launchVM.showHomePage.bind {[unowned self] status in
            if status{
                self.performSegue(withIdentifier: "LaunchToArticleList", sender: self)
            }
        }
        launchVM.isNetworkAvailable.bind {[unowned self] status in
            if !status{
                self.showAlert(title: "Network Error", message: "Network Not Available, Please Check Your Internet Connection")
            }
        }
    }
}
