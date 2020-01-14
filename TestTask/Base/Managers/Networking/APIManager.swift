//
//  NetworkingApi.swift
//  TestTask
//
//  Created by Macintosh on 20/12/2019.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit
import Alamofire


class APIManager {
    
    private init() {}
    
    static let shared = APIManager()
    // json decode
    func getContent(_ completion: @escaping ([Content]?, String?) -> Void) {
          Alamofire.request(urlGet).responseJSON { (response) in
            let decoder = JSONDecoder()
            let result = response.data
            if let contentArray = try? decoder.decode([Content].self, from: result!) {
                print(contentArray)
                print(contentArray.count)
            } else {
                 completion(nil, "Parsing error")
            }
        }
    }
    
    func postContent(content: Content, image: UIImage) {
        let data = image.jpegData(compressionQuality: 1.0)
//       let strBase64 = data.base64EncodedString(options: .lineLength64Characters)

        let dict: Dictionary<String, Any> = ["name": content.name, "typeid": content.id]
        let userData = try? JSONSerialization.data(withJSONObject: dict)
        
     Alamofire.upload(multipartFormData: { (multiFoormData) in
         multiFoormData.append(userData!, withName: "user")
         multiFoormData.append(data!, withName: "photo")
     }, to: url) { (responce) in
         switch responce {
            case .success(let upload, _, _):
                upload.response { answer in
                    print("statusCode: \(String(describing: answer.response?.statusCode))")
                }
                upload.uploadProgress { progress in
                }
            case .failure(let encodingError):
                print("multipart upload encodingError: \(encodingError)")
            }
     }
    }

    
}




