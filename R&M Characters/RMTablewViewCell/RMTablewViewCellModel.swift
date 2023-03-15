//
//  RMTablewViewCellModel.swift
//  R&M Characters
//
//  Created by Raul Moreno on 11/3/23.
//

import Foundation
import UIKit

public class RMTablewViewCellModel {
    
    public var cellImage: UIImage
    public var cellLabelName: String
    public var cellStatusString: String
    public var cellOriginName: String
    
    public init(cellImage: UIImage, cellLabelName: String, cellStatusString: String, cellOriginName: String) {
        self.cellImage = cellImage
        self.cellLabelName = cellLabelName
        self.cellStatusString = cellStatusString
        self.cellOriginName = cellOriginName
    }
}
