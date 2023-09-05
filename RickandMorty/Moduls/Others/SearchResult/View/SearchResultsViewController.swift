//
//  SearchResultsViewController.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 4/9/23.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: CharacterViewModelCell)
}

class SearchResultsViewController: UIViewController {

    // MARK: - Properties
    
    private var characters: [CharacterViewModelCell] = []
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private lazy var aTableView: UITableView = {
        let aTableView = UITableView(frame: .zero, style: .grouped)
        aTableView.delegate = self
        aTableView.dataSource = self
        aTableView.isHidden = true
        aTableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.identifier)
        aTableView.backgroundColor = .systemBackground
        aTableView.rowHeight = 70
        return aTableView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aTableView.frame = view.bounds
        
    }

    // MARK: - Methods
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(aTableView)
    }
    
    func updateView(with model: [CharacterViewModelCell]?) {
        if let characters = model {
            self.characters = characters
            self.aTableView.reloadData()
            self.aTableView.isHidden = false
        } else{
            showAlert(title: "UPS! WE GOT A PROBLEM", message: "We don't have any character with that name")
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier, for: indexPath) as? CharactersTableViewCell else { return UITableViewCell()
        }
        cell.configure(with: characters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didTapResult(characters[indexPath.row])
    }
}

