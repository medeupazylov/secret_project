//
//  DefaultNetworkingService.swift
//  Muslink
//
//  Created by Аброрбек on 12.08.2023.
//

import UIKit

protocol NetworkingService: AnyObject {
    var oauthToken: String { get set }
    
    func registerUser() async throws -> AccessTokenResponse
    func getCities() async throws -> [City]
    func getGenres() async throws -> [Genre]
    func createProfile(profile: Artist) async throws
    func updateProfile(profile: Artist) async throws
    func getProfile(id: Int) async throws -> Artist
    func uploadPhotoFile(data: Data) async throws -> File
    
    func getApplications() async throws -> [Application]
    func getApplication() async throws -> Application
    func createApplication(application: Application) async throws
    func updateApplication(application: Application) async throws
}

final class DefaultNetworkingService: NetworkingService {
    
    private let baseURL: String = "http://130.193.48.155:8080/muslink"
    private var token: String? = "eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJzZWxmIiwic3ViIjoiMTQyMTQ3Mjc5OCIsImV4cCI6MTY5MjkwNzI4OSwiaWF0IjoxNjkyOTAwMDg5LCJzY29wZSI6IkFSVElTVCJ9.gyD4vrjOeP_E8BA7VkJam67iVaQX8dwjxpLwv_CaQqBPsOKFgnAobgJ8WhXxBXhMysrak7TDgSaLGs6_W6T1tLQVlWkLkMWDPCMn59BUZG2O7jQD0C12CwN__1nSxxXrIwUftAteqGrZaAnuugW_MGRH6VL-9wUDlAjVaL6iUSMRXKgnT9hE7OJ-3gIdyLzW2J0QQAnq8Pn9OQNq7Dru4BEG2sLEuhFBJWIamdGi5VDdKU1EGjxmiXl4YIr_LkQPFFOpeSR6RZzu6nbe2bhL5ukmDbCfi1ClV352p0za6lYZOH0YKursCqYLI4xXthovTpZ0aJRLiBulDQt8IF49gA"
    
    
    var oauthToken: String = ""
    private var role: String = "ARTIST"
    private var id = 0
    
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
            print(response)
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
    
    func uploadPhotoFile(data: Data) async throws -> File {
        guard let url = URL(string: "\(self.baseURL)/file/upload/photo") else {
            throw NetworkingError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        var bodyData = Data()
        
        let filename = "\(UUID().uuidString).jpg" // Generate a unique filename
        bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
        bodyData.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        bodyData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        bodyData.append(data)
        bodyData.append("\r\n".data(using: .utf8)!)
        
        bodyData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = bodyData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidServerResponse
        }
        
        let file = try JSONDecoder().decode(
            File.self,
            from: data
        )
        
        return file
    }
    
    func getApplications() async throws -> [Application] {
        guard
            let url = URL(string: "\(baseURL)/artist/applications"),
            let token = token
        else {
            throw NetworkingError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        print(response)
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
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
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
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
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
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            urlRequest.httpBody = try JSONEncoder().encode(application)
            
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkingError.invalidServerResponse
            }
        }
}

