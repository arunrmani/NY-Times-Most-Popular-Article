    //
    //  ArticleData.swift
    //  NY Articles
    //
    //  Created by Safe City Mac 001 on 22/12/2021.
    //

import Foundation

// MARK: - Article Response Model

struct ArticleResponse: Codable{
    var status: String?
    var copyright: String?
    var num_results: Int?
    var results: [ArticleData]?
}
struct ArticleData: Codable{
    var uri: String?
    var url: String?
    var id: Double?
    var asset_id: Double?
    var source: String?
    var published_date: String?
    var updated: String?
    var section: String?
    var subsection: String?
    var nytdsection: String?
    var adx_keywords: String?
    var column: Double?
    var byline: String?
    var type: String?
    var title: String?
    var abstract: String?
    var des_facet: [String]?
    var org_facet: [String]?
    var per_facet: [String]?
    var geo_facet: [String]?
    var media: [Media]?
    var eta_id: Int?
    
    func getFormatedDate(formate: String = "MMM dd,yyyy") -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let endDate = dateFormatter.date(from:published_date ?? ""){
            dateFormatter.dateFormat = formate
            let stringDate = dateFormatter.string(from: endDate)
            return stringDate
        }
        return nil
    }
    
}

struct Media: Codable{
    var type: String?
    var subtype: String?
    var caption: String?
    var copyright: String?
    var approved_for_syndication: Int?
    var media_metadata: [MediaMetaData]?
    
    enum CodingKeys: String,CodingKey{
        case type
        case subtype
        case caption
        case copyright
        case approved_for_syndication
        case media_metadata = "media-metadata"
    }
    
    func getImageUrl(imageType : ImageFormat) -> String?{
        if let media = self.media_metadata?.filter({ $0.format == imageType.rawValue}){
            if media.count > 0 {
                return media[0].url ?? nil
            }
        }
        return nil
    }
}

struct MediaMetaData: Codable{
    var url: String?
    var format: String?
    var height: Int?
    var width: Int?
    
    
}

enum ImageFormat: String{
    case thumbNail = "Standard Thumbnail"
    case medium210 = "mediumThreeByTwo210"
    case medium440 = "mediumThreeByTwo440"
}
