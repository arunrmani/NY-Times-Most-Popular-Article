//
//  ArticledetailsViewModel.swift
//  NY Articles
//
//  Created by Safe City Mac 001 on 22/12/2021.
//

import Foundation
import UIKit
class ArticleDetailsViewModel{
    var articleData: Observable<ArticleData?> = Observable(nil)
    var errorUrl: Observable<Bool> = Observable(false)
    
    init(selectedArticle: ArticleData) {
        self.articleData.value = selectedArticle
    }
    func openReadMore(){
        if let url = URL(string: articleData.value?.url ?? "" ) {
            UIApplication.shared.open(url)
        }
        else{
            self.errorUrl.value = true
        }
    }
}
