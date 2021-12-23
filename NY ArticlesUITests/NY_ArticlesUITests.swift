//
//  NY_ArticlesUITests.swift
//  NY ArticlesUITests
//
//  Created by Safe City Mac 001 on 22/12/2021.
//

import XCTest

class NY_ArticlesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUsualFlow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let exp = expectation(description: "Waiting for API respose(Most popular Articles)")
        exp.isInverted = true
        wait(for: [exp], timeout: 5)
        
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.element.exists)
        
        tablesQuery.element.tap()
        
        let element = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.swipeUp()
        let readMore = app/*@START_MENU_TOKEN@*/.staticTexts["Read More"]/*[[".buttons[\"Read More\"].staticTexts[\"Read More\"]",".staticTexts[\"Read More\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                XCTAssertTrue(readMore.exists)
        let backbutton = app.buttons[" "]
        XCTAssertTrue(backbutton.exists)
        backbutton.tap()

    }
    
   

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
