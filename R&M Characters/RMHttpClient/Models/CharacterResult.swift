//
//  CharacterResult.swift
//  R&M Characters
//
//  Created by Raul Moreno on 10/3/23.
//

import Foundation

public class CharacterResult {
    
    var id: Int
    var name: String
    var status: Constants.RM_CHARACTER_STATUS
    var species: String
    var type: String?
    var gender: Constants.RM_CHARACTER_GENDER
    var origin: CharacterOrigin
    var location: CharacterLocation
    var image: String
    var episode: [String]
    var url: String
    var created: String
    
    public init(id: Int, name: String, status: String, species: String, type: String?, gender: String, origin: CharacterOrigin, location: CharacterLocation, image: String, episode: [String], url: String, created: String)
    {        
        self.id = id
        self.name = name
        self.status = Constants.RM_CHARACTER_STATUS(rawValue: status) ?? .unknown
        self.species = species
        self.type = type
        self.gender = Constants.RM_CHARACTER_GENDER(rawValue: gender) ?? .unknown
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

public class CharacterOrigin {
    var name: String
    var url: String
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

public class CharacterLocation {
    var name: String
    var url: String
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
