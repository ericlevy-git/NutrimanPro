//
//  NPUsdaService.swift
//  NutrimanPro
//
//  Created by Eric Levy on 11/17/18.
//  Copyright © 2018 EL-Visual Systems. All rights reserved.
//

import UIKit
import Alamofire

typealias NPUsdaSearchCompletionBlock = (_ items: NPUsdaSearchResultListItems?, _ error: NSError?) -> Void

enum NPUsdaDataSource: String {
    typealias RawValue = String
    
    case brandedFoodProducts = "Branded Food Products"
    case standardReference = "Standard Reference"
}

enum NPUsdaSort: String {
    typealias RawValue = String
    
    case foodName = "n"
    case relevance = "r"
}

struct NPUsdaSearchItem: Decodable {
    let ds: String
    let group: String
    let manu: String
    let name: String
    let ndbno: String
}

struct NPUsdaSearchResultList: Decodable {
    let list: NPUsdaSearchResultListItems
}

struct NPUsdaSearchResultListItems: Decodable {
    let q: String
    let sr: String
    let ds: String
    let start: Int
    let end: Int
    let total: Int
    let group: String
    let sort: String
    let item: [NPUsdaSearchItem]
}


class NPUsdaService: NSObject {
    private static let kApiKey = "xsIl81BlPxHLwiqctP3c9Sj8oOQfD4wenFOO2zJ2"
    private static let kAccountID = "d4116a30-3f74-4395-b84e-2d3ce5493863"
    private static let kBaseUrl = "https://api.nal.usda.gov/ndb"

    public static func search(_ text: String, offset: Int, maxResults: Int, sort: NPUsdaSort, dataSource: NPUsdaDataSource, completion: NPUsdaSearchCompletionBlock?) {
        guard let path = "/search/?format=json&api_key=\(NPUsdaService.kApiKey)&q=\(text)&offset=\(offset)&max=\(maxResults)&sort=\(sort.rawValue)&ds=\(dataSource.rawValue)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            completion?(nil, nil)
            return
        }

        guard let url = URL(string: "\(NPUsdaService.kBaseUrl)\(path)") else {
            completion?(nil, nil)
            return
        }
        
        Alamofire.request(url).validate().responseJSON { (response) in
            guard response.result.isSuccess, let data = response.data else {
                completion?(nil, nil)
                return
            }
            
            do {
                let resultList = try JSONDecoder().decode(NPUsdaSearchResultList.self, from: data)
                completion?(resultList.list, nil)
            } catch {
                completion?(nil, nil)
            }
            
        }
    }
}
