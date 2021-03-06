//
//  MatchListInteractor.swift
//  Brasileirao
//
//  Created by Fabio Martinez on 08/01/2019.
//  Copyright (c) 2018 Fabio Martinez. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MatchListBusinessLogic {
    func fetchMatches(request: MatchList.FetchMatches.Request.FetchMatches)
    func fetchNextMatches(request: MatchList.FetchMatches.Request.FetchNextMatches)
    func fetchPreviusMatches(request: MatchList.FetchMatches.Request.FetchPreviusMatches)
    func handleMatchSelection(request: MatchList.Route.Request)
}

protocol MatchListDataStore {
    var matches: [Match] { get set }
}

class MatchListInteractor: MatchListDataStore {
    
    var presenter: MatchListPresentationLogic?
    var worker = MatchListWorker()
    private var currentRound = 1

    var matches = [Match]()
    
    
    private func fetchMatches(round: Int) {
        worker.fetchMatches(round: round, completionHandler: { [weak self] result in
            guard let weakSelf = self else { return }
            var response = MatchList.FetchMatches.Response.Succes(matches: [], round: weakSelf.currentRound)
            if let matches = result as? [Match] {
                response.matches = matches
                weakSelf.matches = matches
            } else if let error = result as? Error {
                let realmMatches = weakSelf.worker.loadMatches()
                response.matches = realmMatches
                weakSelf.matches = realmMatches
                weakSelf.presenter?.presentErrorOnFetch(response: MatchList.FetchMatches.Response.Error(message: error.localizedDescription))
            }
            weakSelf.presenter?.presentFetchedMatches(response: response)
        })
    }
}

extension MatchListInteractor: MatchListBusinessLogic {
    
    func handleMatchSelection(request: MatchList.Route.Request) {
        let selectedMatch = matches[request.index]
        let response = MatchList.Route.Response(match: selectedMatch)
        presenter?.presentMatchDetails(response: response)
        
    }
    
    func fetchMatches(request: MatchList.FetchMatches.Request.FetchMatches) {
        fetchMatches(round: currentRound)
    }
    
    func fetchNextMatches(request: MatchList.FetchMatches.Request.FetchNextMatches) {
        currentRound += 1
        fetchMatches(round: currentRound)
    }
    
    func fetchPreviusMatches(request: MatchList.FetchMatches.Request.FetchPreviusMatches) {
        if (currentRound > 1) {
            currentRound -= 1
            fetchMatches(round: currentRound)
        }
    }
}

