//
//  EpisodesViewModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import Foundation

protocol EpisodesViewModelDelegate: AnyObject {
    func updateTable()
}

class EpisodesViewModel {
    // MARK: - properties
    
    var service: EpisodesServiceFetching?
    weak var delegate: EpisodesViewModelDelegate?
    weak var delegateShowError: ShowAlert?
    var delegateSpinner: SpinnersDelegate?
    
    var episodesArray: [EpisodesDetailModel] = []
    
    // MARK: - init
    init(service: EpisodesServiceFetching = EpisodesService()  ) {
        self.service = service
    }
    
    // MARK: - getEpisodes
    func getEpisodes() {
        delegateSpinner?.startProcess()
        service?.get(onComplite: { detail in
            self.episodesArray = detail.results
            self.delegate?.updateTable()
            
            self.delegateSpinner?.stopProcess()
        }, onError: { e in
            self.delegateSpinner?.stopProcess()
            guard let error = e else { return }
            self.delegateShowError?.showAlertWithMessage(message: error)
        })
    }
    
    // MARK: - getEpisodesCount
    
    func getEpisodesCount() -> Int {
        episodesArray.count
    }
    
    func getEpisodesData(index: Int) -> EpisodesDetailModel {
        episodesArray[index]
    }
}
