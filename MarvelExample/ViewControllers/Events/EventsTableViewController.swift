//
//  EventsTableViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 06/10/2022.
//

import UIKit

class EventsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getEvents()
    }
    
    private func getEvents() {
        EventsProvider.shared.getData {
            
        } onSuccess: {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } onFailure: {
            // TODO: Show error message
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EventsProvider.shared.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        let event = EventsProvider.shared.data[indexPath.row]
        cell.bind(with: event)
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
