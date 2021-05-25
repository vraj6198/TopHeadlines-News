//
//  ContentView.swift
//  TopHeadlines
//
//  Created by Vraj Patel on 25/05/21.
//


import SwiftUI

struct ContentView : View {
    
   @StateObject var model: ArticleListViewModel = ArticleListViewModel()
    
    var body: some View {
        
        NavigationView {
            List(model.articles) { article in
                
                NewsRow(article: article)
                }
            .navigationBarTitle("Today's Headlines", displayMode: .automatic)
            
            
            }
            
        }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


