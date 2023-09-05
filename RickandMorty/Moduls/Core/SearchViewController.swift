//
//  SearchViewController.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 4/9/23.
//

import UIKit

class SearchViewController: UIViewController  {

    private lazy var viewModel: SearchViewModel = {
        let viewModel = SearchViewModel()
        return viewModel
    }()
    
    private lazy var aSearchBar: UISearchController = {
        let aSearchBar = UISearchController(searchResultsController: SearchResultsViewController())
        aSearchBar.searchBar.placeholder = "Characters"
        aSearchBar.searchBar.searchBarStyle = .minimal
        aSearchBar.definesPresentationContext = true
        aSearchBar.searchResultsUpdater = self
        aSearchBar.searchBar.delegate = self
        return aSearchBar
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    // MARK: - SetUpView
    private func setUpView() {
        view.backgroundColor = .systemBackground
        navigationItem.searchController = aSearchBar
    }
    
}
// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultController = aSearchBar.searchResultsController as? SearchResultsViewController,
              let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
       
        resultController.delegate = self
        viewModel.fetch(query: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    resultController.updateView(with: model)
                case.failure(let error):
                    self.showAlert(message: error)
                }
            }
        }
    }
    
    private func showAlert(message: Error) {
        let alert = UIAlertController(title: "Ups, We got an Error!", message: message.localizedDescription , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
// MARK: - SearchResultsViewControllerDelegate
extension SearchViewController: SearchResultsViewControllerDelegate {
    func didTapResult(_ result: CharacterViewModelCell) {
        let vc = CharacterViewController(character: result)
        vc.title = result.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
