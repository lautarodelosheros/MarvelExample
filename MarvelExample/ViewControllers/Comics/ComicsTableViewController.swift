//
//  ComicsTableViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import UIKit

class ComicsTableViewController: UITableViewController {

    private var comics = [Comic]()
    
    weak var delegate: ComicsTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        delegate?.didUpdateContentHeight(newValue: tableView.contentSize.height)
    }
    
    func showComics(for character: Character) {
        MarvelAPIClient.default.getCharacterComics(characterId: character.id, pageNumber: 0, pageSize: 20) {
            
        } onSuccess: { comics in
            DispatchQueue.main.async { [weak self] in
                self?.comics = comics
                self?.tableView.reloadData()
            }
        } onFailure: {
            // TODO: Show error
        }
    }
    
    func showComics(for event: Event) {
        MarvelAPIClient.default.getEventComics(eventId: event.id, pageNumber: 0, pageSize: 20) {
            
        } onSuccess: { comics in
            DispatchQueue.main.async { [weak self] in
                self?.comics = comics
                self?.tableView.reloadData()
            }
        } onFailure: {
            // TODO: Show error
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicCell", for: indexPath) as! ComicTableViewCell
        let comic = comics[indexPath.row]
        cell.bind(with: comic)
        return cell
    }
}

protocol ComicsTableViewControllerDelegate: AnyObject {
    
    func didUpdateContentHeight(newValue: CGFloat)
}
