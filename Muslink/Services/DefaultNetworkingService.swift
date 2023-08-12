//
//  DefaultNetworkingService.swift
//  Muslink
//
//  Created by Аброрбек on 12.08.2023.
//

import UIKit

protocol NetworkingService: AnyObject {
    func createProfile(profile: Artist) async throws
    func updateProfile(profile: Artist) async throws
    func getProfile(id: Int) async throws -> Artist
    func getCities() async throws -> [City]
}

final class DefaultNetworkingService: NetworkingService {
    
    private let baseURL: String = "http://localhost:8080"
    private var token: String? = nil
    
    enum NetworkingError: Error {
        case invalidURL
        case invalidServerResponse
        case failureToEncodeDTO
    }
    
    func createProfile(profile: Artist) async throws {
        guard let url = URL(string: "\(self.baseURL)/muslink/artist/profile") else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try JSONEncoder().encode(profile)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidServerResponse
        }
        
        let token = try JSONDecoder().decode(
            String.self,
            from: data
        )
        self.token = token
    }
    
    func updateProfile(profile: Artist) async throws {
        guard let url = URL(string: "\(self.baseURL)/muslink/artist/profile") else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.httpBody = try JSONEncoder().encode(profile)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidServerResponse
        }
        
        let token = try JSONDecoder().decode(
            String.self,
            from: data
        )
        self.token = token
    }
    
    func getProfile(id: Int) async throws -> Artist {
        guard let url = URL(string: "\(self.baseURL)/muslink/artist/profile/\(id)") else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidServerResponse
        }
        
        let profile = try JSONDecoder().decode(
            Artist.self,
            from: data
        )
        
        return profile
    }
    
    func getCities() async throws -> [City] {
        guard let url = URL(string: "\(self.baseURL)/data/cities") else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidServerResponse
        }
        
        let cities = try JSONDecoder().decode(
            [City].self,
            from: data
        )
        
        return cities
    }
    
    func getGenres() async throws -> [Genre] {
        guard let url = URL(string: "\(self.baseURL)/data/genres") else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidServerResponse
        }
        
        let genres = try JSONDecoder().decode(
            [Genre].self,
            from: data
        )
          
        return genres
    }
}

