//
//  ArticleListViewModel.swift
//  TopHeadlines
//
//  Created by Vraj Patel on 25/05/21.
//

import Foundation
import SwiftUI

//init this model by fetchData()

class ArticleListViewModel: ObservableObject {
    
    @Published var articles = [ArticleViewModel]()
    
    init() {
        fetchData()
        
    }

    private func fetchData() {
        NetworkService.loadData() { articles in
            if let articles = articles {
                self.articles = articles.map(ArticleViewModel.init)
                let widgetContent = articles.map { (article) in
                    WidgetContent(title: article.title)
                }
                self.imagesData()
                WidgetContent.writeContents(widgetContent: widgetContent)
            }
        }
    }
    
    private func imagesData(_ index: Int = 0) {
        guard articles.count > index else { return }
        let article = articles[index]
        ImageStore.downloadImageBy(url: article.urlToImage) {
            self.articles[index].image = $0
            if self.articles[0].image != nil, index == 0 {
            WidgetContent.writeImage(image: self.articles[0].image)
            }
            self.imagesData(index + 1)
        }
    }
}
