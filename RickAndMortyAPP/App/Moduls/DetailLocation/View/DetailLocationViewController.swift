//
//  DetailLocationViewController.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import UIKit

class DetailLocationViewController: UIViewController {

    // MARK: - properties
    var location: DetailLocationModel?
    
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
    
    private lazy var viewModel : DetailLocationViewModel = {
        let viewModel = DetailLocationViewModel()
        viewModel.delegate = self
        viewModel.delegateShowError = self
        viewModel.delegateSpinner = self
        return viewModel
    }()
    
    private lazy var locationName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Type:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeValue: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     
    private lazy var dimensionTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Dimension:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dimensionValue: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var residentsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Residents:"
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
        viewModel.getResidents(data: location)
    }
    
    // MARK: - setupView
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [locationName, typeTitle, typeValue, dimensionTitle, dimensionValue, residentsTitle ,aCollectionView, spinner].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            locationName.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            locationName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            locationName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            locationName.heightAnchor.constraint(equalToConstant: 50),
            
            typeTitle.topAnchor.constraint(equalTo: locationName.bottomAnchor, constant: 20),
            typeTitle.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            typeTitle.widthAnchor.constraint(equalToConstant: 70),
            
            typeValue.topAnchor.constraint(equalTo: typeTitle.bottomAnchor, constant: 5),
            typeValue.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            dimensionTitle.topAnchor.constraint(equalTo: typeValue.bottomAnchor, constant: 10),
            dimensionTitle.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            dimensionValue.topAnchor.constraint(equalTo: dimensionTitle.bottomAnchor, constant: 5),
            dimensionValue.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            residentsTitle.topAnchor.constraint(equalTo: dimensionValue.bottomAnchor, constant: 10),
            residentsTitle.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),

            aCollectionView.topAnchor.constraint(equalTo: residentsTitle.bottomAnchor, constant: 5),
            aCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            aCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            aCollectionView.heightAnchor.constraint(equalToConstant: 300),

            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension DetailLocationViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getResidentCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = aCollectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionCell().identifier, for: indexPath) as? ShowCollectionCell else { return UICollectionViewCell() }
        cell.configureCellForResidents(data: viewModel.showResidentsData(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: aCollectionView.frame.width/2, height: aCollectionView.frame.height/1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailViewController()
//        vc.urlDetail = detailViewModel.showResidentsData(index: indexPath.row).url
//        present(vc, animated: true)
    }
    
}

// MARK: - DetailLocationViewModelDelegate
extension DetailLocationViewController: DetailLocationViewModelDelegate {
    func updateView(date: DetailLocationModel) {
        DispatchQueue.main.async {
            self.locationName.text = date.name
            self.typeValue.text = date.type
            self.dimensionValue.text = date.dimension
        }
    }
    
    func hiddenProperty() {
        DispatchQueue.main.async {
            [self.locationName, self.typeTitle, self.typeValue, self.dimensionTitle, self.dimensionValue, self.residentsTitle ,self.aCollectionView].forEach {
                $0.isHidden = true
            }
        }
    }
    
    func showProperty() {
        DispatchQueue.main.async {
            [self.locationName, self.typeTitle, self.typeValue, self.dimensionTitle, self.dimensionValue, self.residentsTitle ,self.aCollectionView].forEach {
                $0.isHidden = false
            }
        }
        
    }
    
    func updateCollecView() {
        DispatchQueue.main.async {
            self.aCollectionView.reloadData()
        }
    }
}

// MARK: - ShowAlert
extension DetailLocationViewController: ShowAlert {
    func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: Constants.AlertTitle.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - SpinnersDelegate
extension DetailLocationViewController: SpinnersDelegate {
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
