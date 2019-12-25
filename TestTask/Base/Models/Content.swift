//
//  Content.swift
//  TestTask
//
//  Created by Macintosh on 20/12/2019.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import Foundation
import Alamofire

struct Content {
    let id: Int
    let name: String
    
    init(dictionary: Dictionary<String, Any>) {
          id = dictionary["id"] as? Int ?? 0
          name = dictionary["name"] as? String ?? ""
}
}
