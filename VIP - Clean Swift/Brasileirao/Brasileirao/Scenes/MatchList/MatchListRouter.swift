//
//  MatchListRouter.swift
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

@objc protocol MatchListRoutingLogic {
    func routeToMatchDetails(segue: UIStoryboardSegue?)
}

protocol MatchListDataPassing {
  var dataStore: MatchListDataStore? { get }
}

class MatchListRouter: NSObject, MatchListRoutingLogic, MatchListDataPassing {
    weak var viewController: MatchListViewController?
    var dataStore: MatchListDataStore?
  
    func routeToMatchDetails(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! MatchDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToMatchDetails(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "MatchDetailsViewController") as! MatchDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToMatchDetails(source: dataStore!, destination: &destinationDS)
            navigateToMatchDetails(source: viewController!, destination: destinationVC)
        }
    }

  // MARK: Navigation
  
    func navigateToMatchDetails(source: MatchListViewController, destination: MatchDetailsViewController) {
        source.show(destination, sender: nil)
    }
  
  // MARK: Passing data
  
    func passDataToMatchDetails(source: MatchListDataStore, destination: inout MatchDetailsDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        if let row = selectedRow {
            destination.match = source.matches[row]
        }
    }
}