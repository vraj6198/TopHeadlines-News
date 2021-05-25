//
//  NewsWidget.swift
//  NewsWidget
//
//  Created by Vraj Patel on 25/05/21.
//

import WidgetKit
import SwiftUI


struct Provider: TimelineProvider {
    
    let defaultContent = NewsWidgetContent(date: Date(),title: "Top News")
    
    func placeholder(in context: Context) -> NewsWidgetContent {
        defaultContent
    }
    
    //data widget displays in widget gallery
    func getSnapshot(in context: Context, completion: @escaping (NewsWidgetContent) -> ()) {
        completion(defaultContent)
    }
    
    //the main method to produce data and timeline
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print(#function)
        //initiate date
        var entryDate = Date()
        
        var entries: [NewsWidgetContent] = []
        //get saved contents from shared container
        
        
        //update contents from Network
        WidgetContent.loadData { (articles) in
            if let articles = articles, articles.count >= 6 { // print("articles.count: \(articles.count)")
                
                for i in 0...8 {

                    //generate date for time line
                    entryDate = Calendar.current.date(byAdding: .minute, value: 10, to: entryDate)!
                    
                    //create entry
                    var newsEntry = NewsWidgetContent(date: entryDate, title: articles[i].title)
                
                    //populate with image if there is some
                    if let urlToImage = articles[i].urlToImage {
                        WidgetContent.downloadImageBy(url: urlToImage) { (image) in
                            newsEntry.image = image
                            print("IMAGE")
                            entries.append(newsEntry)
                            
                            //check for last value
                            if i == 8 {
                                let timeline = Timeline(entries: entries, policy: .atEnd)
                                print("entries.count")
                                print(entries.count)
                                completion(timeline)
                            }
                        }
                    } else {
                    entries.append(newsEntry)
                        
                        //check for last value
                        if i == 8 {
                            let timeline = Timeline(entries: entries, policy: .atEnd)
                            completion(timeline)
                        }
                    }
                }
            }
        }
    }
}


@main
struct NewsWidget: Widget {
    let kind: String = "NewsWidget"
    
    var body: some WidgetConfiguration {
        
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            NewsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("News Widget")
        .description("This is an example of news widget.")
    }
}

struct NewsWidget_Previews: PreviewProvider {
    static var previews: some View {
        NewsWidgetEntryView(entry: NewsWidgetContent(date: Date(), title: "Top News"))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
