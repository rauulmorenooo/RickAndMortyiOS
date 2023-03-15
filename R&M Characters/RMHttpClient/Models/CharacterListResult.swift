//
//  CharacterListResult.swift
//  R&M Characters
//
//  Created by Raul Moreno on 10/3/23.
//

import Foundation

public class CharacterListResult {
    
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
    var results: [CharacterResult]
    
    public init(count: Int, pages: Int, next: String?, prev: String?, results: [CharacterResult]) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
        self.results = results
    }
}
