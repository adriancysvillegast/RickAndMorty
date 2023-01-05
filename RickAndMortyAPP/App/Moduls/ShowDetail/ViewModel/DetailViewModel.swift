//
//  DetailViewModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 3/1/23.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func updateView(data: DetailCharacterModel)
    func updateCollection()
    func hiddenProperty()
    func showProperty()
}

class DetailViewModel {
    
    // MARK: - properties
    var service: DetailServiceFetching?
    
    weak var delegateDetail: DetailViewModelDelegate?
    weak var delegateShowError: ShowAlert?
    var delegateSpinner: SpinnersDelegate?
    
    //    var residentsData: [DetailCharacterModel] = []
    var residenteData: [ResidentsData] = []
    // MARK: - init
    init(service: DetailServiceFetching = DetailService()) {
        self.service = service
    }
    
    // MARK: - getData
    func getDetails(url: String?) {
        if let url = url {
            self.delegateSpinner?.startProcess()
            self.delegateDetail?.hiddenProperty()
            
            self.service?.getDetailCharacter(url: url, onComplete: { detail in
                self.getLocations(url: detail.location.url)
                self.delegateDetail?.updateView(data: detail)
            }, onError: { e in
                self.delegateSpinner?.stopProcess()
                guard let error = e else { return }
                self.delegateShowError?.showAlertWithMessage(message: error)
            })
        }
    }
    
    func getLocations(url: String?) {
        guard let url = url else { return }
        service?.getDetailLocation(url: url, onComplete: { detail in
            self.getResidents(residents: detail.residents)
            
        }, onError: { error in
            guard let error = error else { return }
            self.delegateShowError?.showAlertWithMessage(message: error)
        })
    }
    
    func getResidents(residents: [String]) {
        for resident in residents {
            self.service?.getDetailCharacter(url: resident, onComplete: { detail in
                self.getDataImage(residents: detail)
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
            self.residenteData.append(new)
//            print(new.dataImage)
        }catch {
            self.delegateShowError?.showAlertWithMessage(message: "We couldn't get all images")
        }
        
        self.delegateSpinner?.stopProcess()
        self.delegateDetail?.showProperty()
        self.delegateDetail?.updateCollection()
    }
    
    // MARK: - ShowDataInCollectionView
    
    func getResidentCount() -> Int {
        return residenteData.count
    }
    
    func showResidentsData(index: Int) -> ResidentsData {
        return residenteData[index]
    }
}
