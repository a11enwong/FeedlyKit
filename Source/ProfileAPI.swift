//
//  ProfileAPI.swift
//  FeedlyKit
//
//  Created by Hiroki Kumamoto on 1/20/15.
//  Copyright (c) 2015 Hiroki Kumamoto. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension CloudAPIClient {
    /**
        Get the profile of the user
        GET /v3/profile
    */
    public func fetchProfile(completionHandler: (NSURLRequest, NSHTTPURLResponse?, Profile?, NSError?) -> Void) -> Request {
        return request(Router.FetchProfile).validate().responseObject(completionHandler)
    }


    /**
        Update the profile of the user
        POST /v3/profile
    */
    public func updateProfile(params: [String:String], completionHandler: (NSURLRequest, NSHTTPURLResponse?, Profile?, NSError?) -> Void) -> Request {
        return request(Router.UpdateProfile(params)).validate().responseObject(completionHandler)
    }
}