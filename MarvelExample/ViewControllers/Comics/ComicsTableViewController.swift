//
//  ComicsTableViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import UIKit

class ComicsTableViewController: UITableViewController {

    private var comics = [Comic]() {
        didSet {
            delegate?.didUpdateComics()
            guard isViewLoaded else { return }
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    weak var delegate: ComicsTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        delegate?.didUpdateContentHeight(newValue: tableView.contentSize.height)
    }
    
    func showComics(for character: Character) {
        MarvelAPIClient.default.getCharacterComics(characterId: character.id, pageNumber: 0, pageSize: 20) {
            
        } onSuccess: { [weak self] comics in
            self?.comics = comics
        } onFailure: {
            // TODO: Show error
        }
    }
    
    func showComics(for event: Event) {
        MarvelAPIClient.default.getEventComics(eventId: event.id, pageNumber: 0, pageSize: 20) {
            
        } onSuccess: { [weak self] comics in
            self?.comics = comics
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
    func didUpdateComics()
}
