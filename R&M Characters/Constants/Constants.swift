//
//  RMConstants.swift
//  R&M Characters
//
//  Created by Raul Moreno on 10/3/23.
//

import Foundation

public class Constants {
    
    // MARK: HTTP Methods
    public static let GET = "GET"
    public static let POST = "POST"
    
    // MARK: Rick & Morty
    public static let RM_BASE_URL = "https://rickandmortyapi.com/api/"
    public static let RM_CHARACTER = "character"
    public static let RM_LOCATION = "location"
    public static let RM_EPISODE = "episode"
    
    public static let RM_QUERY_NAME = "name="
    public static let RM_QUERY_STATUS = "type="
    public static let RM_QUERY_GENDER = "gender="
    
    public enum RM_CHARACTER_STATUS: String {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
    
    public enum RM_CHARACTER_GENDER: String {
        case female = "female"
        case male = "male"
        case genderless = "genderless"
        case unknown = "unknown"
    }
}
