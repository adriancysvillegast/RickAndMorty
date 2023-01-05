//
//  CharacterViewModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/23.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func updateView()
}

class CharacterViewModel {
    
    // MARK: - properties
    var service: CharacterServiceFetching?
    weak var delegateHome: HomeViewModelDelegate?
    weak var delegateShowError: ShowAlert?
    
    var characterValue: [DetailCharacterModel] = []
    var infoModelPage: InfoModel?
    
    // MARK: - init
    init(service: CharacterServiceFetching = CharacterService() ) {
        self.service = service
    }
    
    // MARK: - get
    func get() {
        service?.get(onComplete: { data in
            self.characterValue = data.results
            self.infoModelPage = data.info
            self.delegateHome?.updateView()
        }, onError: { error in
            guard let error = error else { return }
            self.delegateShowError?.showAlertWithMessage(message: error)
        })
        
    }
    
    // MARK: - LoadData
    func characterCount() -> Int {
        return characterValue.count
    }
    
    func characterData(index: Int) -> DetailCharacterModel {
        return characterValue[index]
    }    
}
