//
//  ArticleViewModel.swift
//  TopHeadlines
//
//  Created by Vraj Patel on 25/05/21.
//


import Foundation
import SwiftUI

//ViewModel conforms to the Identifiable protocol since it has to supply data to the List. The List uses the id property to make sure that the contents of the list are unique

struct ArticleViewModel: Identifiable {
    
    let id = UUID()
    
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var title: String {
        return self.article.title
    }
    var urlToImage: String {
        return self.article.urlToImage ?? ""
    }
    
    var image: UIImage!
    
}
