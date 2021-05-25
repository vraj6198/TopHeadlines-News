//
//  NewsWidgetEntryView.swift
//  TopHeadlines
//
//  Created by Vraj Patel on 25/05/21.
//

import SwiftUI
import WidgetKit

// View of widget
struct NewsWidgetEntryView : View {
    //var entry: Provider.Entry
    
    var entry: NewsWidgetContent
    
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            VStack {
                Text(entry.title)
                    .font(.subheadline)
                    .lineLimit(nil)
            }
            .padding()
            
        default:
            VStack {
                HStack {
                    Text(entry.title)
                        .font(.title3)
                        .lineLimit(nil)
                        .padding(.bottom, 10)
                   

                    if entry.image != nil {
                        Image(uiImage: entry.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    } else {
                        Image("newspic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    }
                }
            }
            .padding()
        }
    }
}


struct NewsWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let entry = NewsWidgetContent(date: Date(), title: "Top News")
        NewsWidgetEntryView(entry: entry)
    }
}
