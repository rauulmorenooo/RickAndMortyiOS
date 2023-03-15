//
//  RMHttpMapper.swift
//  R&M Characters
//
//  Created by Raul Moreno on 10/3/23.
//

import Foundation

public class RMHttpMapper {
    public static func parseReponse(fromCharacterListResponse response: Data) -> CharacterListResult? {
        do {
            guard let characterListResponseJson = try JSONSerialization.jsonObject(with: response) as? [String: AnyObject] else { return nil }
            guard let info = characterListResponseJson["info"] as? [String: Any] else { return nil }
            guard let results = characterListResponseJson["results"] as? [[String: Any]] else { return nil }
            
            let count = info["count"] as? Int ?? 0
            let pages = info["pages"] as? Int ?? 0
            let next = info["next"] as? String
            let prev = info["prev"] as? String
            
            return CharacterListResult(count: count, pages: pages, next: next, prev: prev, results: parseReponse(fromCharacters: results))
            
        } catch {
            NSLog("Couldn't parseResponse from CharacterList")
        }
        
        return nil
    }
    
    public static func parseReponse(fromCharacters characters: [[String: Any]]) -> [CharacterResult] {
        var characterList: [CharacterResult] = []
        
        
        for character in characters {
            let id = character["id"] as? Int ?? -1
            let name = character["name"] as? String ?? ""
            let status = character["status"] as? String ?? ""
            let species = character["species"] as? String ?? ""
            let characterType = character["type"] as? String ?? ""
            let gender = character["gender"] as? String ?? ""
            
            let origin = character["origin"] as? [String: String] ?? [:]
            let origin_name = origin["name"] ?? ""
            let origin_url = origin["url"] ?? ""
            
            let location = character["origin"] as? [String: String] ?? [:]
            let location_name = location["name"] ?? ""
            let location_url = location["url"] ?? ""
            
            let image = character["image"] as? String ?? ""
            let episodes = character["episode"] as? [String] ?? []
            let url = character["url"] as? String ?? ""
            let created = character["created"] as? String ?? ""
           
            characterList.append(CharacterResult(id: id, name: name, status: status, species: species, type: characterType, gender: gender, origin: CharacterOrigin(name: origin_name, url: origin_url), location: CharacterLocation(name: location_name, url: location_url), image: image, episode: episodes, url: url, created: created))
        }
        
        return characterList
    }
}
