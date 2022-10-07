//
//  ComicTableViewCell.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import UIKit

class ComicTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onSaleDateLabel: UILabel!
    
    private let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "yyyy"
    }
    
    func bind(with comic: Comic) {
        nameLabel.text = comic.title
        if let dates = comic.dates,
           let onSaleComicDate = dates.first(where: { $0.type == "onsaleDate" }),
           let onSaleDate = onSaleComicDate.date {
            onSaleDateLabel.text = dateFormatter.string(from: onSaleDate)
        } else {
            onSaleDateLabel.text = nil
        }
    }
}
