//
//  Subscription.swift
//  MusicFav
//
//  Created by Hiroki Kumamoto on 12/21/14.
//  Copyright (c) 2014 Hiroki Kumamoto. All rights reserved.
//

import SwiftyJSON

public final class Subscription: Stream,
                                 ResponseObjectSerializable, ResponseCollectionSerializable,
                                 ParameterEncodable {
    public let id:         String
    public let title:      String
    public let categories: [Category]
    public let website:    String?
    public let visualUrl:  String?
    public let sortId:     String?
    public let updated:    Int64?
    public let added:      Int64?

    public override var streamId: String {
        return id
    }
    public override var streamTitle: String {
        return title
    }

    public class func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [Subscription] {
        let json = JSON(representation)
        return json.arrayValue.map({ Subscription(json: $0) })
    }

    required public convenience init?(response: NSHTTPURLResponse, representation: AnyObject) {
        let json = JSON(representation)
        self.init(json: json)
    }

    public init(json: JSON) {
        self.id         = json["id"].stringValue
        self.title      = json["title"].stringValue
        self.website    = json["website"].stringValue
        self.categories = json["categories"].arrayValue.map({Category(json: $0)})
        self.visualUrl  = json["visualUrl"].string
        self.sortId     = json["sortid"].string
        self.updated    = json["updated"].int64
        self.added      = json["added"].int64
    }

    public init(feed: Feed, categories: [Category]) {
        self.id         = feed.id
        self.title      = feed.title
        self.categories = categories
    }

    func toParameters() -> [String : AnyObject] {
        return [
                 "title": title,
                    "id": id,
            "categories": categories.map( { $0.toParameters() })
            ]
    }
}
