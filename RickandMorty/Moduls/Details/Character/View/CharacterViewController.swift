//
//  CharacterViewController.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 1/9/23.
//

import UIKit

class CharacterViewController: UIViewController {

    // MARK: - Properties
    let character: CharacterViewModelCell
    
    private lazy var viewModel: CharacterViewModel = {
        let viewModel = CharacterViewModel()
        return viewModel
    }()
    
    // MARK: - Init
    init(character: CharacterViewModelCell) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        viewModel.fetchDetail(url: character.urlInfo) { result in
            switch result {
            case .success(let model): break
            case .failure(let error): break
            }
        }
    }
    
    // MARK: - SetUpView
    private func setUpView() {
        view.backgroundColor = .systemBackground
    }
}
