    //
    //  ArticleListViewModel.swift
    //  NY Articles
    //
    //  Created by Safe City Mac 001 on 22/12/2021.
    //

import Foundation

class ArticleListViewModel{
    
    var articleList: Observable<[ArticleData?]> = Observable([])
    var selectedArticle: Observable<ArticleData?> = Observable(nil)
    var gaTodetails: Observable<Bool> = Observable(false)
    var showError: Observable<APIError?> = Observable(nil)
    var articleListCount: Int  {
        get{
            return self.articleList.value.count
        }
    }
    
    func getArticle(at index:Int) -> ArticleData?{
        guard articleListCount > 0 else{
            return nil
        }
        if let article = self.articleList.value[index]{
            return article
        }
        return nil
    }
    
    func getMostPopularArticleList(){
        ARMLoader.show()
        APIClient.shared.getMostPopularArticle { result in
            ARMLoader.hide()
            switch result{
                case .success(let responseObj):
                    self.articleList.value = responseObj.results ?? []
                case .failure(let error):
                    print(error.localizedDescription)
                    self.showError.value = error
            }
        }
    }
    
    func selectArticle(index: Int){
        self.selectedArticle.value = self.getArticle(at: index)
        self.gaTodetails.value = true
    }
    
    
}
