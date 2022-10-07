//
//  EventDetailViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var comicsView: UIView!
    @IBOutlet weak var comicsViewHeightConstraint: NSLayoutConstraint!
    
    private let event: Event
    
    init(event: Event) {
        self.event = event
        super.init(nibName: "EventDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setUpFrameView()
        setUpComicsTableViewController()
    }
    
    private func setUpFrameView() {
        frameView.layer.cornerRadius = 4
        frameView.layer.shadowColor = UIColor.black.cgColor
        frameView.layer.shadowOpacity = 0.2
        frameView.layer.shadowOffset = CGSize(width: 0, height: 1)
        frameView.layer.shadowRadius = 4
    }
    
    private func setUpComicsTableViewController() {
        let comicsTableViewController = UIStoryboard(name: "Comics", bundle: nil).instantiateInitialViewController() as! ComicsTableViewController
        addChild(comicsTableViewController)
        comicsView.addSubview(comicsTableViewController.view)
        comicsTableViewController.view.frame = comicsView.bounds
        comicsTableViewController.didMove(toParent: self)
        comicsTableViewController.delegate = self
        comicsTableViewController.showComics(for: event)
    }
    
    @IBAction func backgroundButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension EventDetailViewController: ComicsTableViewControllerDelegate {
    
    func didUpdateContentHeight(newValue: CGFloat) {
        comicsViewHeightConstraint.constant = newValue
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func didUpdateComics() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
