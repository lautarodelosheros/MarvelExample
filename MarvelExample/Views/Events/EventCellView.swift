//
//  EventCellView.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import UIKit

@IBDesignable
class EventCellView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private let dateFormatter = DateFormatter()
    private var event: Event?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: EventCellView.self)
        bundle.loadNibNamed("EventCellView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setUpDateFormatter()
        setUpImageView()
    }
    
    private func setUpDateFormatter() {
        dateFormatter.locale = Locale(identifier: "es-ES")
        dateFormatter.monthSymbols = dateFormatter.monthSymbols.map { $0.capitalized }
        dateFormatter.dateFormat = "d 'de' MMMM yyyy"
    }
    
    func bind(with event: Event) {
        self.event = event
        titleLabel.text = event.title
        if let date = event.start {
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = nil
        }
        setEventImage(from: event)
    }
    
    private func setUpImageView() {
        imageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 4)
    }
    
    private func setEventImage(from event: Event) {
        imageView.image = nil
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
            self?.imageView.image = image
        }
    }
}
