//
//  DetailEpisodeViewModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import Foundation

protocol DetailEpisodeViewModelDelegate: AnyObject {
    func hiddenProperty()
    func showProperty()
    func updateCollecView()
    func updateView(data: EpisodesDetailModel)
}

class DetailEpisodeViewModel {
    
    // MARK: - properties
    var service: DetailServiceFetching?
    
    weak var delegate: DetailEpisodeViewModelDelegate?
    var delegateSpinner: SpinnersDelegate?
    weak var delegateShowError: ShowAlert?
    
    var characterData: [ResidentsData] = []
    // MARK: - init
    init(service: DetailServiceFetching = DetailService()) {
        self.service = service
    }
    
    // MARK: - getCharacteres
    func getCharacteres(data: EpisodesDetailModel?) {
        self.delegate?.hiddenProperty()
        self.delegateSpinner?.startProcess()
        guard let data = data else { return }
        for resident in data.characters {
            service?.getDetailCharacter(url: resident, onComplete: { detail in
                self.getDataImage(residents: detail)
                self.delegate?.updateView(data: data)
                
                self.delegateSpinner?.stopProcess()
                self.delegate?.showProperty()
                self.delegate?.updateCollecView()
            }, onError: { error in
                guard let error = error else { return }
                self.delegateShowError?.showAlertWithMessage(message: error)
            })
        }
    }
    
    func getDataImage(residents: DetailCharacterModel) {
        guard let url = URL(string: residents.image) else { return }
        do{
            let value = try Data(contentsOf: url)
            let new = ResidentsData(name: residents.name, dataImage: value, url: residents.url)
            self.characterData.append(new)
//            print(new.dataImage)
        }catch {
            self.delegateShowError?.showAlertWithMessage(message: "We couldn't get all images")
        }
    }
    
    // MARK: - getcountChatater
    func getCharacterCount() -> Int {
        return characterData.count
    }
    
    func showCharacterDataData(index: Int) -> ResidentsData {
        return characterData[index]
    }
}
