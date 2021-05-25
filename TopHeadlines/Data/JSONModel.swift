//
//  JSONModel.swift
//  TopHeadlines
//
//  Created by Vraj Patel on 25/05/21.
//

import Foundation

struct JSONModel: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let title: String
    let url: String
    let urlToImage: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
