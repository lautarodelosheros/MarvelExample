//
//  CharacterTableViewCell.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 05/10/2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(with character: Character) {
        nameLabel.text = character.name.uppercased()
        descriptionLabel.text = character.description
        setCharacterImage(from: character)
    }
    
    private func setCharacterImage(from character: Character) {
        characterImageView.image = nil
        guard let thumbnail = character.thumbnail else {
            return
        }
        ImageProvider.shared.getImage(
            path: thumbnail.path,
            fileExtension: thumbnail.extension
        ) { [weak self] image in
            self?.characterImageView.image = image
        }
    }
}
