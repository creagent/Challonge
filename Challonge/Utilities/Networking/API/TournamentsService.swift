//
//  TournamentsService.swift
//  Challonge
//
//  Created by Антон Алексеев on 18.03.2022.
//

import Foundation

class TournamentsService: NetworkService<TournamentsEndPoint> {
    @discardableResult
    func createTournament(register: TournamentRegister) -> URLSessionTask? {
        return executeRequest(to: TournamentsEndPoint.create(register: register)) { (result: Data?, error) in
            let serializer = Serializer()
//            do {
//                let resultResponse = try serializer.serialize(type: ResultResponse.self, from: result)
//                complete(resultResponse, error)
//            } catch {
//                complete(nil, error)
//            }
        }
    }
    
    @discardableResult
    func getTournament(complete: @escaping ([TournamentResponse]?, Error?) -> Void) -> URLSessionTask? {
        return executeRequest(to: TournamentsEndPoint.get) { (result: Data?, error) in
            let serializer = Serializer()
            do {
                let resultResponse = try serializer.serialize(type: [TournamentResponse].self, from: result)
                complete(resultResponse, error)
            } catch {
                complete(nil, error)
            }
        }
    }
}
