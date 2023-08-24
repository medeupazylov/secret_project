//
//  ApplicationNetworkingService.swift
//  Muslink
//
//  Created by Аброрбек on 19.08.2023.
//

import UIKit

protocol ApplicationNetworkingService: AnyObject {
    func getApplications() async throws -> [Application]
    func getApplication() async throws -> Application
    func createApplication(application: Application) async throws
    func updateApplication(application: Application) async throws
}

final class ApplicationNetworkingServiceImpl: ApplicationNetworkingService {
    
    private let baseURL: String = "http://130.193.48.155:8080/muslink"
    private var token: String? = nil
    private var id = 0
    
    enum NetworkingError: Error {
        case invalidURL
        case invalidServerResponse
        case failureToEncodeDTO
    }
    
    func getApplications() async throws -> [Application] {
        guard let url = URL(string: "\(baseURL)/applications") else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidServerResponse
        }
        
        let applications = try JSONDecoder().decode(
            [Application].self,
            from: data
        )
        
        return applications
    }
    
    func getApplication() async throws -> Application {
            guard let url = URL(string: "\(baseURL)/application/\(self.id)") else {
                throw NetworkingError.invalidURL
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkingError.invalidServerResponse
            }
            
            let application = try JSONDecoder().decode(
                Application.self,
                from: data
            )
            
            return application
        }
        
        func createApplication(application: Application) async throws {
            guard let url = URL(string: "\(baseURL)/application") else {
                throw NetworkingError.invalidURL
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = try JSONEncoder().encode(application)
            
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkingError.invalidServerResponse
            }
        }
        
        func updateApplication(application: Application) async throws {
            guard let url = URL(string: "\(baseURL)/applications/\(self.id)") else {
                throw NetworkingError.invalidURL
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "PUT"
            urlRequest.httpBody = try JSONEncoder().encode(application)
            
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkingError.invalidServerResponse
            }
        }
}
