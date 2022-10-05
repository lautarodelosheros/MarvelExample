//
//  CharacterTableViewCell.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 05/10/2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(with character: Character) {
        nameLabel.text = character.name
    }
}
