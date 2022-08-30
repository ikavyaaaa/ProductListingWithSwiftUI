//
//  Product.swift
//  ProductListingSwiftUI
//
//  Created by Kavya on 30/08/22.
//

import Foundation

struct Product: Hashable, Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Hashable, Codable {
    let rate: Double
    let count: Int
}

extension Product {
    var formatedRating: String {
        var result = ""
        for _ in 0...Int(rating.rate){
            result.append("★")
        }
        while result.count<5{
            result += "☆"
        }
        return result
    }
}
