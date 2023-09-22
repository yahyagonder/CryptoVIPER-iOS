//
//  Interactor.swift
//  CryptoVIPER
//
//  Created by Yahya Gönder on 30.07.2022.
//

import Foundation

//Talks to -> Presenter
//Class, Protocol
//görevi, veriyi indirmek ve presenter'a haber vermek.

protocol AnyInteractor {
    
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
    
}

class CryptoInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        
        guard let url = URL(string: "") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, response, error in
            
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkFailed.NetworkFailed))
                return
            }
            
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            } catch {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkFailed.ParsingFailed))
            }
            
        }
        
        task.resume()
        
    }
    
}

