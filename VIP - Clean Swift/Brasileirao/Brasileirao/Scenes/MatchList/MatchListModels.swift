//
//  MatchListModels.swift
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

enum MatchList
{

    enum FetchMatches {

        struct Request {

            struct FetchMatches
            {
            }

            struct FetchNextMatches
            {
            }

            struct FetchPreviusMatches
            {
            }

        }

        struct Response {
            struct Succes {
                var matches: [Match]
                var round: Int
            }
            
            struct Error {
                let message: String
            }
        }

        struct ViewModel {

            struct MessageViewModel {
                var message: String
                var bgCollor: UIColor
            }
            
            struct RefreshViewModel {
                var displayRefreshControl: Bool
            }

            var matches: [MatchViewModel]
            var screentitle: String
 
        }

    }

    enum Route {
        struct Request {
            var index: Int
        }

        struct Response {
            var match: Match
        }

        struct ViewModel {

        }
    }

}
