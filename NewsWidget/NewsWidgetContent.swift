//
//  NewsWidgetContent.swift
//  TopHeadlines
//
//  Created by Vraj Patel on 25/05/21.
//

import WidgetKit
import SwiftUI

class WidgetImage: ObservableObject {
    @Published var widgetimage: Image = WidgetContent.readImage()!
}


struct NewsWidgetContent: TimelineEntry {
    var date: Date
    var title: String
    var image: UIImage?
    
}


struct WidgetContent:Codable {
    var date = Date()
    var title: String
   
}

extension WidgetContent{
    
    //saves image in shared container
    static func writeImage(image: UIImage) {
        if let archiveURL = FileManager.sharedContainerURL() {
            let url = archiveURL.appendingPathComponent("widgetImage.png")
            print("writeImage: \(url)")
            guard let data = image.pngData() else { return }
            do {
                try data.write(to: url)
            } catch {
                print("Error saving image file ")
            }
            
        }
    }
    
    //read saved image in shared container
    static func readImage() -> Image? {
        if let archiveURL = FileManager.sharedContainerURL() {
            let url = archiveURL.appendingPathComponent("widgetImage.png")
            print("readImage: \(url)")
            if FileManager.default.fileExists(atPath: url.path) {
                print("Image found!")
                let img = Image(url.path)
                return img
            } else {
                print("Error reading image file ")
            }
        }
        return nil
    }
    
    //saves struct shared container
    static func writeContents(widgetContent: [WidgetContent]) {
        if let archiveURL = FileManager.sharedContainerURL() {
            let url = archiveURL.appendingPathComponent("contents")
            print("writeContents: \(url)")
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            if let data = try? encoder.encode(widgetContent) {
                do {
                    try data.write(to: url)
                } catch {
                    print("Error: Can't write contents")
                    return
                }
            }
        }
    }
    
    //read struct from xml in shared container
    static func readContents() -> [WidgetContent] {
        if let archiveURL = FileManager.sharedContainerURL() {
            let url = archiveURL.appendingPathComponent("contents")
            let decoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: url)
                return try decoder.decode([WidgetContent].self, from: data)
            } catch {
                print(error)
                print(error.localizedDescription)
            }
        }
        return []
    }
    
    
    //Network update
    static func loadData(completion: @escaping ([Article]?) -> ()) {
        
        let urlString = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=072f1453f70d45d9a88bf86d7a0b92d8"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data, error == nil {
                
                let response = try? JSONDecoder().decode(JSONModel.self, from: data)
                if let response = response {
                    DispatchQueue.main.async {
                        completion(response.articles)
                    }
                }
            } else {
                print("Error in: \(#function)")
                completion(nil)
            }
        }
        task.resume()
        
    }
    
    //get images from network
    static func downloadImageBy(url: String, completion: @escaping (UIImage)->Void) {
        
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
                }
            }
        }
        task.resume()
    }
    
}

//URL to shared container
extension FileManager {
    static func sharedContainerURL() -> URL? {
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.vraj.TopHeadlines.contents"
        )
    }
}

