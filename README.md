# NY-Times-Most-Popular-Article
## _Latest Most Popular Article from New York Times_
### arun r mani

This app supports iPhones and iPads with Portrait orientation running iOS 13.0 Built with Xcode Version 13.0. Written in Swift 5.0.


This Sample project shows a list of the New York Times most popular articles from the last 7 days.In Home Sreen User can find list of latest most popular articles of New York Times.and
that shows details when items on the list are tapped.

- The sample application Created with for iOS 13.0 or latter
- Xcode Version 13.0
- Swift Version 5
- All the code structured in MVVM pattern
- Sample code implements UnitTest and UITest using XCTest framework
- Native Network layer is user for  API calls.
- SD WebImage pod is userd for handling image from URL 
- Storyboard is used for UI Integration


## Features

- We'll be using the most viewed section of this API.
 https://developer.nytimes.com/apis
- http://api.nytimes.com/svc/mostpopular/v2/mostviewed/{section}/{period}.json?api- key=sample-key
To test this API, you can use all-sections for the section path component in the URL above and 7 for period (available period values are 1, 7 and 30, which represents how far back, in days, the API returns results for).
http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api- key=sample-key
- To generate API-Key for free: http://developer.nytimes.com/signup

## App Details

Dillinger uses a number of open source projects to work properly:

- Create an account in NY Times Public API
https://developer.nytimes.com/apis
- Create an application in Your Account you will get api-key
- Using API Key You can call Most popular articles
http://api.nytimes.com/svc/mostpopular/v2/mostviewed/{section}/{period}.json?api- key=sample-key

- Create a network layer for API Call
- Create a Data Model Class cor API Response
- Launch Page Check Network is Available or not.
- Home Page: Listing Most popular Articles from API call
- Details Page : Showing the details of article
- Read More : This option will redirect to safari to read full article.

## How To Use

Download the sample application and create your on account in NY Times public api (https://developer.nytimes.com/apis). replace api-Key in General.swift class. 

Enjoy 🏆🏆🏆


