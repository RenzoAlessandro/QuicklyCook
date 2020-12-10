//
//  SRRecipe.swift
//  Swifty Recipes
//
//  Created by Lasse Hammer Priebe on 12/02/16.
//  Copyright © 2016 Hundredeni. All rights reserved.
//

import UIKit

open class SRRecipe: NSObject, NSCoding {
    
    // MARK: Properties
    
    public let title: String!
    public let ingredients: String!
    public let url: URL!
    public let thumbnailUrl: URL?
    
    open var thumbnailImage: UIImage? {
        get {
            return SRPuppyClient.sharedClient().imageCache.imageWithIdentifier(thumbnailUrl?.path)
        }
        set {
            if let thumbnailPath = thumbnailUrl?.path {
                SRPuppyClient.sharedClient().imageCache.storeImage(newValue, withIdentifier: thumbnailPath)
            }
        }
    }
    
    fileprivate struct CodingKeys {
        static let Title = "title"
        static let Href = "href"
        static let Ingredients = "ingredients"
        static let Thumbnail = "thumbnail"
    }
    
    // MARK: Life Cycle
    
    public init(title: String, ingredients: String, url: URL, thumbnailUrl: URL?) {
        self.title = title
        self.ingredients = ingredients
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
    // MARK: NSCoding Protocol
    
    @objc open func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: CodingKeys.Title)
        aCoder.encode(url, forKey: CodingKeys.Href)
        aCoder.encode(ingredients, forKey: CodingKeys.Ingredients)
        aCoder.encode(thumbnailUrl, forKey: CodingKeys.Thumbnail)
    }
    
    @objc public required init?(coder aDecoder: NSCoder) {  
        title = aDecoder.decodeObject(forKey: CodingKeys.Title) as? String
        ingredients = aDecoder.decodeObject(forKey: CodingKeys.Ingredients) as? String
        url = aDecoder.decodeObject(forKey: CodingKeys.Href) as? URL
        thumbnailUrl = aDecoder.decodeObject(forKey: CodingKeys.Thumbnail) as! URL?
    }
    
    // MARK: - CustomStringConvertible Protocol
    override open var description: String {
        get {
            return "Recipe: \(String(describing: title)).\nIngredients: \(String(describing: ingredients))"
        }
    }
}
