//
//  CharacterDetailViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var comicsTitleLabel: UILabel!
    @IBOutlet weak var comicsView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var comicsViewHeightConstraint: NSLayoutConstraint!
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
        super.init(nibName: "CharacterDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setUpNavigationItem()
        setUpComicsTableViewController()
        scrollView.delegate = self
        reloadData()
    }
    
    private func setUpNavigationItem() {
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(onBackTouched))
        navigationItem.setLeftBarButton(backButtonItem, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setUpComicsTableViewController() {
        let comicsTableViewController = UIStoryboard(name: "Comics", bundle: nil).instantiateInitialViewController() as! ComicsTableViewController
        addChild(comicsTableViewController)
        comicsView.addSubview(comicsTableViewController.view)
        comicsTableViewController.view.frame = comicsView.bounds
        comicsTableViewController.didMove(toParent: self)
        comicsTableViewController.delegate = self
        comicsTableViewController.showComics(for: character)
    }
    
    private func reloadData() {
        navigationItem.title = character.name.uppercased()
        descriptionLabel.text = character.description
        setCharacterImage()
    }
    
    private func setCharacterImage() {
        guard let thumbnail = character.thumbnail else {
            return
        }
        ImageProvider.shared.getImage(
            path: thumbnail.path,
            fileExtension: thumbnail.extension
        ) { [weak self] image in
            self?.imageView.image = image
        }
    }
    
    @objc private func onBackTouched() {
        navigationController?.popViewController(animated: true)
    }
}

extension CharacterDetailViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
}

extension CharacterDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.y < 0 {
            var transform = CATransform3DTranslate(CATransform3DIdentity, 0, offset.y, 0)
            let scaleFactor = 1 + (-1 * offset.y / (view.frame.width / 2))
            transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1)
            imageView.layer.transform = transform
        } else {
            imageView.layer.transform = CATransform3DIdentity
        }
    }
}

extension CharacterDetailViewController: ComicsTableViewControllerDelegate {
    
    func didUpdateContentHeight(newValue: CGFloat) {
        comicsViewHeightConstraint.constant = newValue
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func didUpdateComics(isEmpty: Bool) {
        comicsTitleLabel.isHidden = isEmpty
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
