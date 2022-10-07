//
//  EventTableViewCell.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 06/10/2022.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var eventCellView: EventCellView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCardView()
    }
    
    private func setUpCardView() {
        cardView.layer.cornerRadius = 4
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cardView.layer.shadowRadius = 4
    }
    
    func bind(with event: Event) {
        eventCellView.bind(with: event)
    }
}
