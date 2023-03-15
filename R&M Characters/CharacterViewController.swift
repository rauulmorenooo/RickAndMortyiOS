//
//  CharacterViewController.swift
//  R&M Characters
//
//  Created by Raul Moreno on 13/3/23.
//

import Foundation
import UIKit

public class CharacterViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var infoContainerVIew: UIView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterStatusImage: UIImageView!
    @IBOutlet weak var characterStatusSpeciesLabel: UILabel!
    @IBOutlet weak var characterOriginLabel: UILabel!
    @IBOutlet weak var characterLocationLabel: UILabel!
    
    public var character: CharacterResult?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let character = character {
            characterNameLabel.text = character.name
            
            let statusSpecies = "\(character.status.rawValue) - \(character.species)"
            characterStatusSpeciesLabel.text = statusSpecies
            
            characterOriginLabel.text = character.origin.name
            
            characterLocationLabel.text = character.location.name
            
            RMHttpClient.shared.getImage(fromUrl: character.image) { image in
                DispatchQueue.main.async {
                    self.characterImageView.image = image
                    
                    var color: UIColor = .white
                    
                    switch (character.status) {
                    case .alive:
                        color = .green
                    case .dead:
                        color = .red
                    case .unknown:
                        color = .gray
                    }
                    self.characterStatusImage.image = UIImage(color: color)
                }
            }
        }
    }
}
