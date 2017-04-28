//
//  EventLocationCell.swift
//  LetSwift
//
//  Created by Marcin Chojnacki on 26.04.2017.
//  Copyright © 2017 Droids On Roids. All rights reserved.
//

import UIKit

final class EventLocationCell: AppTableViewCell {
    
    @IBOutlet private weak var locationLabel: UILabel!
    
    var placeName = "Proza" {
        didSet {
            refreshLocationLabel()
        }
    }
    
    var placeLocation = "Wrocławski Klub Literacki\nPrzejście Garncarskie 2, Rynek Wrocław" {
        didSet {
            refreshLocationLabel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        refreshLocationLabel()
    }
    
    private func refreshLocationLabel() {
        locationLabel.attributedText = placeName.uppercased()
            .attributed(withFont: UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightSemibold))
            .with(color: .black) + " — " + placeLocation.attributed()
    }
}