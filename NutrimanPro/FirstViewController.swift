//
//  FirstViewController.swift
//  NutrimanPro
//
//  Created by Eric Levy on 11/16/18.
//  Copyright © 2018 EL-Visual Systems. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NPUsdaService.search("chocolate", offset: 0, maxResults: 20, sort: .relevance, dataSource: .standardReference) { (listItems, error) in
            guard let listItems = listItems else {
                return
            }
            
            for item in listItems.item {
                print("\(item.name)")
            }
        }
        
    }


}

