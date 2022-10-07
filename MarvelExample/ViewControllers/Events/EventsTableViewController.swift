//
//  EventsTableViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 06/10/2022.
//

import UIKit

class EventsTableViewController: UITableViewController {

    @IBOutlet weak var closeSessionButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpNavigationItem()
        getEvents()
    }
    
    private func setUpTableView() {
        tableView.contentInset = UIEdgeInsets(top: 9, left: 0, bottom: 9, right: 0)
    }
    
    private func setUpNavigationItem() {
        let textAttributes = [
            NSAttributedString.Key.font: UIFont(name: "RobotoCondensed-Bold", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
        ]
        closeSessionButton.setTitleTextAttributes(textAttributes, for: .normal)
        closeSessionButton.setTitleTextAttributes(textAttributes, for: .selected)
    }
    
    private func getEvents() {
        EventsProvider.shared.getData {
            
        } onSuccess: {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } onFailure: { [weak self] error in
            self?.showError(message: error.localizedDescription)
        }
    }
    
    @IBAction func closeSessionButtonTouched(_ sender: Any) {
        KeychainManager.remove(key: .token)
        dismiss(animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if EventsProvider.shared.data.isEmpty {
            // Skeleton cells
            return EventsProvider.shared.pageSize
        }
        return EventsProvider.shared.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        if indexPath.row > EventsProvider.shared.data.count - 1 {
            cell.showAnimatedSkeleton()
        } else {
            cell.hideSkeleton()
            let event = EventsProvider.shared.data[indexPath.row]
            cell.bind(with: event)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row < EventsProvider.shared.data.count else { return }
        let event = EventsProvider.shared.data[indexPath.row]
        let eventDetailViewController = EventDetailViewController(event: event)
        eventDetailViewController.modalTransitionStyle = .crossDissolve
        eventDetailViewController.modalPresentationStyle = .overFullScreen
        present(eventDetailViewController, animated: true)
    }
}
