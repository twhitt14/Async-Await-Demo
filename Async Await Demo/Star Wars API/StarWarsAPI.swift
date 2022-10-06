//
//  StarWarsAPI.swift
//  Async Await Demo
//
//  Created by Trevor Whittingham on 9/22/22.
//

import Foundation

class StarWarsAPI {
    
    typealias PersonAPIResult = Result<[StarWarsPerson], Error>
    
    let peopleURL = URL(string: "https://swapi.dev/api/people")!
    
    func loadPeople(completion: @escaping (PersonAPIResult) -> ()) {
        let request = URLRequest(url: peopleURL)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure("No data was returned"))
                return
            }
            
            let personResponse: StarWarsPersonResponse
            
            do {
                personResponse = try JSONDecoder().decode(StarWarsPersonResponse.self, from: data)
            } catch {
                completion(.failure(error))
                return
            }
            
            completion(.success(personResponse.results))
        }
        .resume()
    }
    
    func loadPeopleAsync() async throws -> [StarWarsPerson] {
        let request = URLRequest(url: peopleURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(StarWarsPersonResponse.self, from: data)
        
        return response.results
    }
}
