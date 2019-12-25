//
//  NetworkingApi.swift
//  TestTask
//
//  Created by Macintosh on 20/12/2019.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit
import Alamofire


// https://junior.balinasoft.com/api/v2/photo/type
// https://junior.balinasoft.com/api/v2/photo


class APIManager {
    
    private init() {}
    
    static let shared = APIManager()
    // json decode
    func getContent(_ completion: @escaping ([Content]?, String?) -> Void) {
        var contentArray: [Content] = []
          Alamofire.request("https://junior.balinasoft.com/api/v2/photo/type").responseJSON { (response) in
            print(response.result)
            if let error = response.error {
                completion(nil, error.localizedDescription)
            }
            let result = response.result
                if let dict = result.value as? Dictionary<String, Any> {
                    if let content = dict["content"] as? Array<Any> {
                        for item in content {
                            let value = Content(dictionary: item as! Dictionary<String, Any>)
                                 contentArray.append(value)
                        }
                    }
                        
                    print(contentArray)
                    print(contentArray.count)
                    completion(contentArray, nil)
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

           let url = "https://junior.balinasoft.com/api/v2/photo"
        
     Alamofire.upload(multipartFormData: { (multiFoormData) in
         multiFoormData.append(userData!, withName: "user")
         multiFoormData.append(data!, withName: "photo")
     }, to: url) { (encodingResult) in
         switch encodingResult {
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




