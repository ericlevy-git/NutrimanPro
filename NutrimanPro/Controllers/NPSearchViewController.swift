//
//  NPSearchViewController.swift
//  NutrimanPro
//
//  Created by Eric Levy on 11/17/18.
//  Copyright © 2018 EL-Visual Systems. All rights reserved.
//

import UIKit

class NPSearchViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
