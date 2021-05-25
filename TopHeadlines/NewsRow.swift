//
//  NewsRow.swift
//  TopHeadlines
//
//  Created by Vraj Patel on 25/05/21.
//

import SwiftUI

struct NewsRow: View {
   
    var article: ArticleViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                HStack(alignment: .top, spacing: 10) {
                    Text(article.title)
                        .lineLimit(nil)
                        .font(.title2)
                    Spacer()
                    if article.image != nil {
                        Image(uiImage: article.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    }
                }
                .padding(.top)
                .padding(.bottom)
                
            }
        }
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(article: ArticleListViewModel().articles[0])
            
    }
}
