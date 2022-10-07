//
//  CharactersTableViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 03/10/2022.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    private let sections: [Section] = [.characters, .loadMore]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getCharacters()
    }
    
    private func setUpTableView() {
        tableView.register(
            UINib(nibName: "LoadMoreTableViewCell", bundle: nil),
            forCellReuseIdentifier: "loadMoreCell"
        )
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .characters:
            return CharactersProvider.shared.data.count
        case .loadMore:
            return CharactersProvider.shared.theresMoreData ? 1 : 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .characters:
            return characterCell(at: indexPath)
        case .loadMore:
            return loadMoreCell(at: indexPath)
        }
    }
    
    private func characterCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterTableViewCell
        let character = CharactersProvider.shared.data[indexPath.row]
        cell.bind(with: character)
        return cell
    }
    
    private func loadMoreCell(at indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "loadMoreCell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        guard section == .characters,
              !CharactersProvider.shared.data.isEmpty,
              !CharactersProvider.shared.isFetchingData,
              CharactersProvider.shared.theresMoreData
        else {
            return
        }
        if indexPath.row >= CharactersProvider.shared.data.count - 5 {
            getCharacters()
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let section = sections[indexPath.section]
        switch section {
        case .characters:
            return indexPath
        case .loadMore:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = CharactersProvider.shared.data[indexPath.row]
        let characterDetailViewController = CharacterDetailViewController(character: character)
        characterDetailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(characterDetailViewController, animated: true)
    }
    
    private enum Section {
        case characters
        case loadMore
    }
}
