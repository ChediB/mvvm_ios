//
//  WebService.swift
//  HeadlinesApp
//
//  Created by Chedi Baccari on 29/08/2018.
//  Copyright © 2018 Chedi Baccari. All rights reserved.
//

import Foundation

public class WebService {
    
    func loadSources(completion: @escaping ([Source]) -> ()) {
        let sourceURL = URL(string :"https://newsapi.org/v2/sources?apiKey=8b35a0c331874585a307a2a08f58d4d6")!
        
        URLSession.shared.dataTask(with: sourceURL) { data, _, _ in
            
            if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dictionary = json as! [String:Any]
                let sourcesDictionary = dictionary["sources"] as! [[String:Any]]
                
                let sources = sourcesDictionary.compactMap(Source.init)
                
                DispatchQueue.main.async {
                    completion(sources)
                }
            }
            
            }.resume()
    }
    
    func loadHeadLines(source: Source, completion: @escaping ([Headline]) -> ()) {
      
        // get the headlines by source
        let url = URL(string :"https://newsapi.org/v2/top-headlines?sources=\(source.id)&apiKey=8b35a0c331874585a307a2a08f58d4d6")!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dictionary = json as! [String:Any]
                let headlineDictionaries = dictionary["articles"] as! [[String:Any]]
                
                let headlines = headlineDictionaries.compactMap(Headline.init)
                
                DispatchQueue.main.async {
                    completion(headlines)
                }
            }
            
            }.resume()
    }
}
