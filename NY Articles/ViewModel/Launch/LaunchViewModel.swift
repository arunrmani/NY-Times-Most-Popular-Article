//
//  LaunchViewModel.swift
//  NY Articles
//
//  Created by Safe City Mac 001 on 22/12/2021.
//

import Foundation

class LaunchViewModel{
    
    var showHomePage: Observable<Bool> = Observable(false)
    var isNetworkAvailable: Observable<Bool> = Observable(true)

    func ValidateApp(){
        self.checkNetWork()
    }
}

extension LaunchViewModel{
    @objc func statusManager(_ notification: Notification) {
        checkNetWork()
    }
    private func checkNetWork() {
        switch Network.reachability.status {
            case .unreachable:
                self.showHomePage.value = false
                self.isNetworkAvailable.value  = false
            case .wwan:
                self.showHomePage.value = true
            case .wifi:
                self.showHomePage.value = true
        }
//        print("Reachability Summary")
//        print("Status:", Network.reachability.status)
//        print("HostName:", Network.reachability.hostname ?? "nil")
//        print("Reachable:", Network.reachability.isReachable)
//        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
}
