//
//  ArticleListVCTest.swift
//  NY ArticlesTests
//
//  Created by Safe City Mac 001 on 22/12/2021.
//

import XCTest
@testable import NY_Articles

class ArticleListVCTest: XCTestCase {
    func test_InitiateArticleListVC() throws{
        _ = try makeSUT()
    }
    
    func test_ViewDidLoad_configurationTableView() throws{
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView.delegate,"TableView deligate is nil")
        XCTAssertNotNil(sut.tableView.dataSource,"TableView dataSourse is nil")
    }
    
    func test_ViewModelInitialState(){
        let vm = ArticleListViewModel()
        
        XCTAssertFalse(vm.gaTodetails.value)
        XCTAssertEqual(vm.articleListCount, 0)
        XCTAssertNil(vm.selectedArticle.value)
        XCTAssertNil(vm.getArticle(at:0))

    }
    
//    func test_APIcall() throws{
//        let sut = try makeSUT()
//        sut.loadViewIfNeeded()
//        sut.articleListVM.getMostPopularArticleList()
//        
//        let exp = expectation(description: "Waiting for API respose(Most popular Articles)")
//        exp.isInverted = true
//        wait(for: [exp], timeout: 5)
//        
//        XCTAssertGreaterThan(sut.articleListVM.articleListCount, 0)
//
//    }
    
    func test_MockData() throws{
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        let vm = ArticleListViewModel()
        vm.articleList.value = self.loadMockDataFromJson()
        sut.articleListVM = vm
        XCTAssertEqual(sut.numberOfRows(),20)
        XCTAssertEqual(sut.articleName(atRow: 0),"The 25 Essential Dishes to Eat in New York City")
        XCTAssertEqual(sut.authorName(atRow: 0),"By Dan Piepenbring, Kurt Soller, Amiel Stanek, Korsha Wilson and Daniel Terna")
    }
    

}

extension ArticleListVCTest{
    private func makeSUT()throws -> ArticleListViewController{
        let bundle = Bundle(for: ArticleListViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        let loginVC = sb.instantiateViewController(identifier: "ArticleListViewController")
        return try XCTUnwrap(loginVC as? ArticleListViewController)
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

private extension ArticleListViewController{
    func numberOfRows() -> Int {
        return tableView.numberOfRows(inSection: resultSection)
    }
    func articleName(atRow row : Int) -> String?{
        return dataCell(arRow: row)?.articleNameLbl.text
    }
    func authorName(atRow row : Int) -> String?{
        return dataCell(arRow: row)?.authorLbl.text
    }
    func dataCell(arRow row: Int) -> ArticleDataCell?{
        let ds = tableView.dataSource
        let indexPath = IndexPath(row: row, section: resultSection)
        let cell = ds?.tableView(tableView, cellForRowAt: indexPath) as? ArticleDataCell
        return cell
    }
    private var resultSection: Int { 0 }
}
