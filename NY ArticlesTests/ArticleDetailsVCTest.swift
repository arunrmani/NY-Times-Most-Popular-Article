//
//  ArticleDetailsVCTest.swift
//  NY ArticlesTests
//
//  Created by Safe City Mac 001 on 22/12/2021.
//

import XCTest
@testable import NY_Articles

class ArticleDetailsVCTest: XCTestCase {
    func test_InitiateArticleListVC() throws{
        _ = try makeSUT()
    }
    
    func test_MockData() throws{
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        let articles = loadMockDataFromJson()
        let selectedArticle = articles[0]
        sut.articleDetailsVM = ArticleDetailsViewModel(selectedArticle: selectedArticle)
        sut.bindViewModel()
        XCTAssertEqual(sut.titleLbl.text,"The 25 Essential Dishes to Eat in New York City")
        XCTAssertEqual(sut.authorLbl.text,"By Dan Piepenbring, Kurt Soller, Amiel Stanek, Korsha Wilson and Daniel Terna")
    }
    
    
    
    
  
}

extension ArticleDetailsVCTest{
    private func makeSUT()throws -> ArticleDetailsViewController{
        let bundle = Bundle(for: ArticleDetailsViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        let loginVC = sb.instantiateViewController(identifier: "ArticleDetailsViewController")
        return try XCTUnwrap(loginVC as? ArticleDetailsViewController)
    }
    private func loadMockDataFromJson() -> [ArticleData] {
        if let url = Bundle.main.url(forResource: "sample", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ArticleResponse.self, from: data)
                return jsonData.results ?? []
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
}
