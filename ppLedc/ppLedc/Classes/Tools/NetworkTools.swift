//
//  NetworkTools.swift
//  ppLedc
//
//  Created by 柴荣臻 on 2019/7/16.
//  Copyright © 2019 rzchai. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(type: MethodType, URLString: String, parameters: [String:NSString]? = nil, finishedCallback: @escaping (_ result : AnyObject) -> ()) {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.error!)
                return;
            }
            finishedCallback(result as AnyObject)
        }
    }
    
    class func getRequest(URLString: String, parameters: [String:NSString]? = nil,finishedCallback: @escaping (_ result : AnyObject) -> ()) {
        requestData(type: .GET, URLString: URLString, parameters: parameters, finishedCallback: finishedCallback)
    }
    
    class func postRequest(URLString: String, parameters: [String:NSString]? = nil,finishedCallback: @escaping (_ result : AnyObject) -> ()) {
        requestData(type: .POST, URLString: URLString, parameters: parameters, finishedCallback: finishedCallback)
    }
    
}
