//
//  OnboardingCollectionViewCell.swift
//  GroupAssignment
//
//  Created by Dohee Kim on 2025-04-10.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    
    @IBOutlet weak var slideTitleLbl: UILabel!
    
    
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    
    
    func setup(_ slide: OnboardingSlide){
        
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
    
}
