//
//  RMHttpClient.swift
//  R&M Characters
//
//  Created by Raul Moreno on 10/3/23.
//

import Foundation
import UIKit

public class RMHttpClient {
    
    public static let shared = RMHttpClient()
    
    private let session: URLSession
    private let characterListCache: NSCache<NSString, CharacterListResult>
    private let imageCache: NSCache<NSString, UIImage>
    
    private init() {
        self.session = URLSession.shared
        self.imageCache = NSCache<NSString, UIImage>()
        self.characterListCache = NSCache<NSString, CharacterListResult>()
    }
    
    public func getRickAndMortyCharacterList(withUrl url: String,completion: (@escaping(CharacterListResult) -> ())) {
        if let cachedCharacterList = self.characterListCache.object(forKey: url as NSString) {
            completion(cachedCharacterList)
        } else {
            if let requestUrl = URL(string: url) {
                var request = URLRequest(url: requestUrl)
                request.httpMethod = Constants.GET
                
                self.session.dataTask(with: request) { data, response, error in
                    if let data = data, let characterList = RMHttpMapper.parseReponse(fromCharacterListResponse: data) {
                        self.characterListCache.setObject(characterList, forKey: url as NSString)
                        completion(characterList)
                    }
                }.resume()
            }
        }
    }
    
    public func getImage(fromUrl url: String, completion: @escaping((UIImage) -> ())) {
        
        if let cachedImage = self.imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
        } else {
            if let requestUrl = URL(string: url) {
                var request = URLRequest(url: requestUrl)
                request.httpMethod = Constants.GET
                
                self.session.dataTask(with: request) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        self.imageCache.setObject(image, forKey: url as NSString)
                        completion(image)
                    }
                }.resume()
            }
        }
    }
}
