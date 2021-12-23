//
//  NY_ArticlesTests.swift
//  NY ArticlesTests
//
//  Created by Safe City Mac 001 on 22/12/2021.
//

import XCTest
@testable import NY_Articles

class NY_ArticlesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testInitAppNav() throws{
        _ = try makeSUT()
    }
    
}

extension NY_ArticlesTests{
    private func makeSUT() throws -> LaunchViewController{
        let bundle = Bundle(for: LaunchViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        let launchVC = sb.instantiateInitialViewController()
        let nav = try XCTUnwrap(launchVC as? UINavigationController)
        return try XCTUnwrap(nav.topViewController as? LaunchViewController)
    }
}
