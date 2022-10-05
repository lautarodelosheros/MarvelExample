//
//  CharactersTableViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 03/10/2022.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getCharacters()
    }
    
    private func getCharacters() {
        CharactersProvider.shared.getData {
            
        } onSuccess: {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } onFailure: {
            // TODO: Show some error message
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CharactersProvider.shared.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        let character = CharactersProvider.shared.data[indexPath.row]
        cell.bind(with: character)
        return cell
    }
}
