//
//  SpeakerCardListCell.swift
//  LetSwift
//
//  Created by Marcin Chojnacki on 11.05.2017.
//  Copyright © 2017 Droids On Roids. All rights reserved.
//

import UIKit

final class SpeakerCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var card: SpeakerCardView!
    
    private var speakerTapListener: (() -> Void)?
    private var readMoreTapListener: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    private func setup() {
        removeSeparators()

        card.addSpeakerTapTarget(target: self, action: #selector(speakerDidTap))
        card.addReadMoreTapTarget(target: self, action: #selector(readMoreDidTap))
    }

    func loadData(with model: Talk) {
        card.lectureSummary = model.description
        card.lectureTitle = model.title
        card.speakerName = model.speaker?.name
        card.speakerTitle = model.speaker?.job
        card.speakerImageURL = model.speaker?.avatar?.thumb
    }

    func addTapListeners(speaker: @escaping () -> Void, readMore: @escaping () -> Void) {
        speakerTapListener = speaker
        readMoreTapListener = readMore
    }
    
    @objc private func speakerDidTap() {
        speakerTapListener?()
    }
    
    @objc private func readMoreDidTap() {
        readMoreTapListener?()
    }
}