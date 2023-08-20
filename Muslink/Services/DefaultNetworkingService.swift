//
//  DefaultNetworkingService.swift
//  Muslink
//
//  Created by Аброрбек on 12.08.2023.
//

import UIKit

protocol NetworkingService: AnyObject {
    func registerUser() async throws -> AccessTokenResponse
    func getCities() async throws -> [City]
    func getGenres() async throws -> [Genre]
    func createProfile(profile: Artist) async throws
    func updateProfile(profile: Artist) async throws
    func getProfile(id: Int) async throws -> Artist
}

final class DefaultNetworkingService: NetworkingService {
    
    private let baseURL: String = "http://130.193.48.155:8080/muslink"
    private var token: String? = "eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJzZWxmIiwic3ViIjoiMTQyMTQ3Mjc5OCIsImV4cCI6MTY5MjUxNjcwMSwiaWF0IjoxNjkyNTA5NTAxLCJzY29wZSI6IkFSVElTVCJ9.jHJ-YipfY-4tVMvZGpTjMABPbSsJlSSPu-OIv0hwVeL4m9C7d6jcjkRDfHKSLam5nVvAwR1-tvjc_jPk2JOFjeVvJyPsS6TkV_8wako67_IcGtr8CKiILYp1X5JnaJIYmFTDzJCsp8UQ737JTi7BFT0V7QQTUlqtQ1U6plksB4OrfCn0xV_ZHbPVm4s-1uFTpSUjBUhU5_K2anzZFcHC1sixg2hvbLS_ynIjr0UQSZoTZCXPl2trbga7wP7CFHKUp7WY9JmUgCK9YqPst8TF7inxvjfUft-4oWtMN_TsSbi0F4GxfZgLaLWVn3_b8zhyMRrZP42rA8esHZOqMe_YVQ"
    private var oauthToken: String = "y0_AgAAAABUufQeAApTxAAAAADqmKBJlGqSHXrMSC--QjuaIzB_OSZE17E"
    private var role: String = "ARTIST"
    
    enum NetworkingError: Error {
        case invalidURL
        case invalidServerResponse
        case failureToEncodeDTO
    }
    
    func registerUser() async throws -> AccessTokenResponse {
        guard let url = URL(string: "\(self.baseURL)/register") else {
            throw NetworkingError.invalidURL
        }
        
        let body = AuthResponse(oauthToken: oauthToken, role: role)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(body)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkingError.invalidServerResponse
            }
            
            let accessTokenResponse = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
            token = accessTokenResponse.accessToken
            return accessTokenResponse
        } catch {
            throw error
        }
    }
    
    func getCities() async throws -> [City] {
        guard
            let url = URL(string: "\(self.baseURL)/data/cities"),
            let token = token
        else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
        guard
            let url = URL(string: "\(self.baseURL)/data/genres"),
            let token = token
        else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
    
    func createProfile(profile: Artist) async throws {
        guard
            let url = URL(string: "\(self.baseURL)/artist/profile"),
            let token = token
        else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try JSONEncoder().encode(profile)
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidServerResponse
        }
    }
    
    func updateProfile(profile: Artist) async throws {
        guard let url = URL(string: "\(self.baseURL)/artist/profile") else {
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
        guard
            let url = URL(string: "\(self.baseURL)/artist/profile/\(id)"),
            let token = token
        else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
}

