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
}

final class DefaultNetworkingService: NetworkingService {
    
    private let baseURL: String = "http://130.193.48.155:8080/muslink"
    private var token: String? = "eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJzZWxmIiwic3ViIjoiMTQyMTQ3Mjc5OCIsImV4cCI6MTY5MjczNTU4NSwiaWF0IjoxNjkyNzI4Mzg1LCJzY29wZSI6IkFSVElTVCJ9.Kzjb4H2DbLR2uwanFX89lDZ0njfyAFtVmjrJLJInCeKSCh7mzjPmvlmXIJxQsctOqsc4TK8QyLnJHOjSsc95i1taAKuiM6a7dngRy6UgKA5L_rB_OxTb-aJQWOtuBo-PCHRlwsPu594QN14WMW8XVj1xYTjy4bQwBQ0knFJ85Cu272gHK7i83J8T6s-CUIpbqQKfd2UDY2CzScfebAhJ1G6JQRpFABkTTZMY0aqGDpjlYMdfRhIqMd8smhBriQe4764rgCa1L9HQPMfXINpIygWf8h2tOhqg803mS6AWiY9OtJWEC9tuBMyN9kmOXjIB6rBNgtN1Z9Q8sAVAHsirrg"
    
    
    var oauthToken: String = ""
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
}

