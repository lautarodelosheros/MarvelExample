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
        // TODO: Implement cache
        characterImageView.image = nil
        guard let thumbnail = character.thumbnail,
              let url = URL(string: "\(thumbnail.path).\(thumbnail.extension)")
        else {
            return
        }
        DispatchQueue.global().async {
            if let image = UIImage(from: url) {
                DispatchQueue.main.async { [weak self] in
                    self?.characterImageView.image = image
                }
            }
        }
    }
}
