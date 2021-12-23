    //
    //  APIClient.swift
    //  NY Articles
    //
    //  Created by Safe City Mac 001 on 22/12/2021.
    //

import Foundation
import UIKit
#if canImport(FoundationNetworking)
import FoundationNetworking
import Accelerate
#endif
class APIClient : NSObject{
    
    static let shared = APIClient()
    typealias resultCallBack = (Result<Data,APIError>)-> Void
    func callAPIRequest(semaphoreId:Int,request:URLRequest,completion:@escaping resultCallBack) {
        let semaphore = DispatchSemaphore (value: semaphoreId)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidAPI))
                return
            }
            //print("API Status : \(httpResponse.statusCode)")
            switch httpResponse.statusCode {
                case 200:
                    guard let data = data else {
                        completion(.failure(.invalidAPIResponse))
                        semaphore.signal()
                        return
                    }
                    completion(.success(data))
                    semaphore.signal()
                case 401:
                    completion(.failure(.authenticationError))
                    return
                case 400:
                    completion(.failure(.badRequest))
                    return
                case 503:
                    completion(.failure(.serviceUnAvailable))
                    return
                default:
                    completion(.failure(.unexpected(code: httpResponse.statusCode)))
                    return
            }
        }
        task.resume()
        semaphore.wait()
    }
    
}

extension APIClient{
  
    
        //Mark:- GET Most Popular List
    typealias mpstPopularArticleResultCallBack = (Result<ArticleResponse,APIError>)-> Void

    func getMostPopularArticle(completionHandler: @escaping  mpstPopularArticleResultCallBack){
        
        let url = self.createURL(baseURL: General.BaseURL, urlType: .GET_MOST_POPULAR)
        
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        self.callAPIRequest(semaphoreId: 1, request: request) { result in
            switch result{
                case .success(let data):
                    self.processGetMostPopular(data: data, callBack: completionHandler)
                case .failure(let error):
                    completionHandler(.failure(error))
            }
        }
        
    }
    
}




extension APIClient{
    
    private func dicToJsonString(dictionary : [String:Any]) -> String{
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            let theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
                //print("JSON string = \(theJSONText!)")
            return theJSONText ?? ""
        }
        return ""
    }
    
    
    private func createURL(baseURL: String,urlType: URLType) -> String{
        switch urlType{
            case .GET_MOST_POPULAR:
               return baseURL + urlType.rawValue + "api-key=\(General.APIKey)"
        }
    }
    

    
    private func processGetMostPopular(data:Data,callBack:@escaping mpstPopularArticleResultCallBack){
        do{
            let responseObj =  try JSONDecoder().decode(ArticleResponse.self, from: data)
            callBack(.success(responseObj))
        }
        catch let error{
            print(error.localizedDescription)
            callBack(.failure(.convertionError))
        }
        }
    
}

    //API URLS
enum URLType: String{
    case GET_MOST_POPULAR = "mostpopular/v2/emailed/7.json?"
    
}
