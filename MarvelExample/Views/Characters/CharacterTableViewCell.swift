//
//  CharacterTableViewCell.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 05/10/2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpShadowView()
    }
    
    private func setUpShadowView() {
        shadowView.layer.cornerRadius = 4
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        shadowView.layer.shadowRadius = 4
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
