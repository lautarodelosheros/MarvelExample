//
//  EventTableViewCell.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 06/10/2022.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    private let dateFormatter = DateFormatter()
    private var event: Event?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.locale = Locale(identifier: "es-ES")
        dateFormatter.monthSymbols = dateFormatter.monthSymbols.map { $0.capitalized }
        dateFormatter.dateFormat = "d 'de' MMMM yyyy"
    }
    
    func bind(with event: Event) {
        self.event = event
        eventTitleLabel.text = event.title
        if let date = event.start {
            eventDateLabel.text = dateFormatter.string(from: date)
        } else {
            eventDateLabel.text = nil
        }
        setEventImage(from: event)
    }
    
    private func setEventImage(from event: Event) {
        eventImageView.image = nil
        guard let thumbnail = event.thumbnail else {
            return
        }
        ImageProvider.shared.getImage(
            path: thumbnail.path,
            fileExtension: thumbnail.extension
        ) { [weak self] image in
            guard event.id == self?.event?.id else {
                // Discard image if event changed
                return
            }
            self?.eventImageView.image = image
        }
    }
}
