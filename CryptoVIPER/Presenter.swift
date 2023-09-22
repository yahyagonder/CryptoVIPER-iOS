//
//  Presenter.swift
//  CryptoVIPER
//
//  Created by Yahya Gönder on 30.07.2022.
//

import Foundation

//Talks to -> interactor, router, view
//Class, Protocol
//Sadece okunacaksa {get}, okunup değiştirilecekse {get set}

enum NetworkFailed : Error {
    
    case NetworkFailed
    case ParsingFailed
    
}

protocol AnyPresenter {
    
    var router: AnyRouter? {get set}
    
    var interactor: AnyInteractor? {get set}
    
    var view: AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>)
    
}


class CryptoPresenter: AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCryptos()
            //bu değer atanınca bunu yap, anlamına gelir "did set".
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "try again")
        }
    }
    
}


