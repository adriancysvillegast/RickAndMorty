//
//  DetailLocationViewModel.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/23.
//

import Foundation

protocol DetailLocationViewModelDelegate: AnyObject {
    func updateView(date: DetailLocationModel)
    func hiddenProperty()
    func showProperty()
    func updateCollecView()
}

class DetailLocationViewModel {
    // MARK: - properties
    var service: DetailServiceFetching?
    
    weak var delegate: DetailLocationViewModelDelegate?
    var delegateShowError: ShowAlert?
    var delegateSpinner: SpinnersDelegate?
    
    
    var residenteData: [ResidentsData] = []
    // MARK: - init
    init(service: DetailServiceFetching = DetailService() ) {
        self.service = service
    }
    
    // MARK: - getResidents
    func getResidents(data: DetailLocationModel?) {
        self.delegate?.hiddenProperty()
        self.delegateSpinner?.startProcess()
        guard let value = data else { return }
            for resident in value.residents {
                service?.getDetailCharacter(url: resident, onComplete: { detail in
                    self.getDataImage(residents: detail)
                    self.delegate?.updateView(date: value)
                    
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
            self.residenteData.append(new)
//            print(new.dataImage)
        }catch {
            self.delegateShowError?.showAlertWithMessage(message: "We couldn't get all images")
        }
        
    }
    
    // MARK: - ShowDataInCollectionView
    func getResidentCount() -> Int {
        return residenteData.count
    }
    
    func showResidentsData(index: Int) -> ResidentsData {
        return residenteData[index]
    }
}
