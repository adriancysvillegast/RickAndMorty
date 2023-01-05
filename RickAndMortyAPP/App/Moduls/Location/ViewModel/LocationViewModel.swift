//
//  LocationViewModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import Foundation

protocol LocationViewModelDelegate: AnyObject {
    func updateTableView()
    func hiddenProper()
    func showProper()
}

class LocationViewModel {
    
    // MARK: - properties
    
    var service: LocationServiceFetching?
    
    weak var delegateShowError: ShowAlert?
    weak var delegate: LocationViewModelDelegate?
    var delegateSpinner: SpinnersDelegate?
    
    var detailInfo: InfoModel?
    var locations: [DetailLocationModel] = []
    // MARK: -  init
    init(service: LocationServiceFetching = LocationService()) {
        self.service = service
    }
    
    func getLocation() {
        delegate?.hiddenProper()
        delegateSpinner?.startProcess()
        service?.get( onComplete: { detail in
            self.detailInfo = detail.info
            self.locations = detail.results
            self.delegateSpinner?.stopProcess()
            self.delegate?.showProper()
        }, onError: { e in
            guard let error = e else{ return }
            self.delegateShowError?.showAlertWithMessage(message: error)
            self.delegate?.hiddenProper()
            self.delegateSpinner?.stopProcess()
        })
        self.delegate?.updateTableView()
    }
    
    // MARK: - getCountLocation
    func getCountLocation() -> Int {
        return locations.count
    }
    
    // MARK: - getDataLocation
    func getDataLocation(index: Int) -> DetailLocationModel {
        return locations[index]
    }
}
