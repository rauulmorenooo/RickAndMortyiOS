//
//  RMTablewViewCell.swift
//  R&M Characters
//
//  Created by Raul Moreno on 11/3/23.
//

import Foundation
import UIKit

public class RMTablewViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterStatusImageView: UIImageView!
    
    private var model: RMTablewViewCellModel?
    
    public func configure(withRMTableViewCellModel model: RMTablewViewCellModel) {
        self.model = model
        
        DispatchQueue.main.async {
            
            self.containerView.layer.cornerRadius = 6
            self.containerView.layer.masksToBounds = true
            self.containerView.layer.borderColor = UIColor.black.cgColor
            self.containerView.layer.borderWidth = 0.5
            
            self.characterNameLabel.text = model.cellLabelName
            
            self.characterImageView.image = model.cellImage
            self.characterImageView.layer.borderColor = UIColor.black.cgColor
            self.characterImageView.layer.borderWidth = 0.5
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.containerView.bounds
            gradientLayer.shouldRasterize = true
            gradientLayer.colors = [#colorLiteral(red: 0, green: 0.5725490196, blue: 0.2705882353, alpha: 0.6).cgColor, #colorLiteral(red: 1, green: 0.9333333333, blue: 0.1294117647, alpha: 0.6).cgColor]//UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 0.6).cgColor]
            self.containerView.layer.insertSublayer(gradientLayer, at: 0)
            
        }
    }
}
