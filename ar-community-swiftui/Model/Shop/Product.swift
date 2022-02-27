//
//  Product.swift
//  ar-community-swiftui
//
//  Created by Mammut Nithammer on 04.02.22.
//

import Foundation

typealias ProductResponse = [Product]

struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let permalink: String
    let type: String
    let status: String
    let productDescription: String
    let shortDescription: String
    let price: String
    let purchasable: Bool
    let categories: [ProductCategory]
    let images: [ProductImage]
    let attributes: [ProductAttribute]
    let defaultAttributes: [ProductDefaultAttribute]
    let variations: [Int]
    let stockStatus: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case permalink
        case type
        case status
        case productDescription = "description"
        case shortDescription = "short_description"
        case price
        case purchasable
        case categories
        case images
        case attributes
        case defaultAttributes = "default_attributes"
        case variations
        case stockStatus = "stock_status"
    }
}

struct ProductCategory: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct ProductImage: Codable, Identifiable, Hashable {
    let id: Int
    let src: String
}

struct ProductAttribute: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let position: Int
    let visible: Bool
    let options: [String]
}

struct ProductDefaultAttribute: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let option: String
}
