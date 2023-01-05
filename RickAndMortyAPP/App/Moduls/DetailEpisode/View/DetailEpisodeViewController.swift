//
//  DetailEpisodeViewController.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import UIKit

class DetailEpisodeViewController: UIViewController {

    // MARK: - properties
    private lazy var contentSize = CGSize(width: view.frame.size.width, height: 800)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize = contentSize
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.bounces = true
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.frame.size = contentSize
        return aView
    }()
    
    var episodeSelected: EpisodesDetailModel?
    
    private lazy var viewModel : DetailEpisodeViewModel = {
        let viewModel = DetailEpisodeViewModel()
        viewModel.delegate = self
        viewModel.delegateShowError = self
        viewModel.delegateSpinner = self
        return viewModel
    }()
    
    private lazy var episodeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var airDateTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Air Date:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var airDateValue: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    private lazy var episodeTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Episode:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var episodeValue: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var charactersTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Characters:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let aCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        aCollection.backgroundColor = .white
        aCollection.delegate = self
        aCollection.dataSource = self
        aCollection.register(ShowCollectionCell.self, forCellWithReuseIdentifier: ShowCollectionCell().identifier)
        aCollection.translatesAutoresizingMaskIntoConstraints = false
        return aCollection
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .black
        spinner.isHidden = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        viewModel.getCharacteres(data: episodeSelected)
    }
    
    // MARK: - setupView
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [episodeName, airDateTitle, airDateValue, episodeTitle, episodeValue, charactersTitle ,aCollectionView, spinner].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            episodeName.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            episodeName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            episodeName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            episodeName.heightAnchor.constraint(equalToConstant: 50),
            
            airDateTitle.topAnchor.constraint(equalTo: episodeName.bottomAnchor, constant: 20),
            airDateTitle.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            airDateValue.topAnchor.constraint(equalTo: airDateTitle.bottomAnchor, constant: 5),
            airDateValue.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            episodeTitle.topAnchor.constraint(equalTo: airDateValue.bottomAnchor, constant: 10),
            episodeTitle.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            episodeValue.topAnchor.constraint(equalTo: episodeTitle.bottomAnchor, constant: 5),
            episodeValue.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            charactersTitle.topAnchor.constraint(equalTo: episodeValue.bottomAnchor, constant: 10),
            charactersTitle.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),

            aCollectionView.topAnchor.constraint(equalTo: charactersTitle.bottomAnchor, constant: 5),
            aCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            aCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            aCollectionView.heightAnchor.constraint(equalToConstant: 300),

            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }

}

// MARK: - ShowAlert
extension DetailEpisodeViewController: ShowAlert {
    func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: Constants.AlertTitle.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - DetailEpisodeViewModelDelegate
extension DetailEpisodeViewController:  DetailEpisodeViewModelDelegate{
    func hiddenProperty() {
        DispatchQueue.main.async {
            [self.episodeName, self.airDateTitle, self.airDateValue, self.episodeTitle, self.episodeValue, self.charactersTitle, self.aCollectionView].forEach {
                $0.isHidden = true
            }
        }
    }
    
    func showProperty() {
        DispatchQueue.main.async {
            [self.episodeName, self.airDateTitle, self.airDateValue, self.episodeTitle, self.episodeValue, self.charactersTitle, self.aCollectionView].forEach {
                $0.isHidden = false
            }
        }
    }
    
    func updateCollecView() {
        DispatchQueue.main.async {
            self.aCollectionView.reloadData()
        }
    }
    
    func updateView(data: EpisodesDetailModel) {
        DispatchQueue.main.async {
            self.episodeName.text = data.name
            self.airDateValue.text = data.airDate
            self.episodeValue.text = data.episode
        }
    }
}


// MARK: - SpinnersDelegate
extension DetailEpisodeViewController: SpinnersDelegate {
    func startProcess() {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.spinner.isHidden = false
        }
    }
    
    func stopProcess() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DetailEpisodeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCharacterCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = aCollectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionCell().identifier, for: indexPath) as? ShowCollectionCell else { return UICollectionViewCell() }
        cell.configureCellForResidents(data: viewModel.showCharacterDataData(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: aCollectionView.frame.width/2, height: aCollectionView.frame.height/1)
    }
    
    
}
