//
//  Router.swift
//  CryptoVIPER
//
//  Created by Yahya Gönder on 30.07.2022.
//

import Foundation
import UIKit

//Class, Protocol
//Entry-Point

typealias EnrtyPoint = AnyView & UIViewController

protocol AnyRouter {
    
    var entry : EnrtyPoint? {get}
    
    static func startExecution() -> AnyRouter
    
}

class CryptoRouter : AnyRouter {
    
    var entry: EnrtyPoint?
    
    static func startExecution() -> AnyRouter {
        
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? EnrtyPoint
        
        return router
        
    }
    
}
