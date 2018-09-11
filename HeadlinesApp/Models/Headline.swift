//
//  Headline.swift
//  HeadlinesApp
//
//  Created by Chedi Baccari on 29/08/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation

class Headline {
    
    var title :String!
    var description :String!
    
    init?(dictionary :[String:Any]) {
        
        guard let title = dictionary["title"] as? String,
            let description = dictionary["description"] as? String else {
                return nil
        }
        
        self.title = title
        self.description = description
    }
    
}
