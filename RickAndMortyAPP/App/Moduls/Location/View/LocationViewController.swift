//
//  LocationViewController.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import UIKit

class LocationViewController: UIViewController {

    // MARK: - properties
    
    private lazy var viewModel: LocationViewModel = {
        let viewModel = LocationViewModel()
        viewModel.delegate = self
        viewModel.delegateShowError = self
        viewModel.delegateSpinner = self
        return viewModel
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .black
        spinner.isHidden = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var aTable: UITableView = {
        let aTableView = UITableView()
        aTableView.delegate = self
        aTableView.dataSource = self
        aTableView.backgroundColor = .white
        aTableView.register(ShowCell.self, forCellReuseIdentifier: ShowCell().identifier)
        aTableView.translatesAutoresizingMaskIntoConstraints = false
        return aTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        viewModel.getLocation()
    }
    
    // MARK: - setupView
    func setupViews() {
        view.addSubview(aTable)
        aTable.addSubview(spinner)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            aTable.topAnchor.constraint(equalTo: view.topAnchor),
            aTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            aTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            aTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: aTable.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: aTable.centerYAnchor)
        ])
    }

}

// MARK: - ShowAlert
extension LocationViewController: ShowAlert {
    func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: Constants.AlertTitle.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - SpinnersDelegate
extension LocationViewController: SpinnersDelegate {
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

// MARK: - LocationViewModelDelegate
extension LocationViewController: LocationViewModelDelegate {
    func hiddenProper() {
        DispatchQueue.main.async {
            [self.aTable].forEach {
                $0.isHidden = true
            }
        }
    }
    
    func showProper() {
        DispatchQueue.main.async {
            [self.aTable].forEach {
                $0.isHidden = false
            }
        }
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.aTable.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCountLocation()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = aTable.dequeueReusableCell(withIdentifier: ShowCell().identifier, for: indexPath) as? ShowCell  else { return UITableViewCell() }
        cell.configureCell(data: viewModel.locations[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc  = DetailLocationViewController()
        vc.location = viewModel.locations[indexPath.row]
        vc.title = viewModel.locations[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
