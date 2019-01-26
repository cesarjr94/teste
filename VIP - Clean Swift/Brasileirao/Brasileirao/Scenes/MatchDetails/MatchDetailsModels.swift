//
//  MatchDetailsModels.swift
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

enum MatchDetailsItemType {
    case matchItem(match: Match)
    case bidItem(bid: Bid)
    case bidToBidItem
    case loadingItem
}

enum MatchDetailsCellType {
    case matchCell(cellViewModel: MatchViewModel)
    case bidCell(cellViewModel: MatchDetails.FetchBids.ViewModel.BidViewModel)
    case bidToBidCell
    case loadingCell(loading: String)
}

enum MatchDetails
{
 
    enum FetchBids
    {
        struct Request
        {
            struct Loading {
                let isLoading: Bool
            }
        }
        
        struct Response
        {
            struct Succes {
                var dataSource: [MatchDetailsItemType]
            }
            
            struct Error {
                let message: String
            }
            
            struct WaitingMessage
            {
                var message: String
            }
            
            struct HideMessage
            {

            }
            
        }

        struct ViewModel
        {
            struct BidViewModel {
                let period: String
                let time: String
                let title: String
                let text: String
                
                init(_ bid: Bid) {
                    self.period = bid.period
                    self.time   = bid.textTime()
                    self.title  = bid.title
                    self.text   = bid.text
                }
            }

            struct MessageViewModel {
                var message: String
                var bgCollor: UIColor
            }
            
            struct HideMessage {
                
            }

            var dataSource: [MatchDetailsCellType]

        }
    }
    
    enum GetTitle {
        struct Request {

        }
        struct Response {
            let match: Match
        }
        struct ViewModel {
            struct TitleViewModel {
                let title: String
            }

        }
    }

}