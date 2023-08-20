//
//  ArtistRegistrationViewModel.swift
//  Muslink
//
//  Created by Аброрбек on 11.08.2023.
//

import Foundation

@MainActor
final class ArtistRegistrationViewModel {
    
    //MARK: - Properties
    var name: String?
    var nickname: String?
    var city: City?
    var socialNetworks: [SocialNetwork]?
    var genres: [Genre]?
    var photos: [Photo]?
    
    private let networkingService: NetworkingService
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func registerUser(completion: @escaping (Result<AccessTokenResponse, Error>) -> Void) {
        Task {
            do {
                let registeredUser = try await networkingService.registerUser()
                completion(.success(registeredUser))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func createProfile(completaion: @escaping (Result<Void, Error>) -> Void) {
        guard
              let name = name,
              let nickname = nickname,
              let city = city,
              let socialNetworks = socialNetworks,
              let genres = genres,
              let photos = photos
        else {
            print("Some required properties are missing.")
            return
        }
        
        let profile = Artist(
                            name: name,
                            nickname: nickname,
                            city: city,
                            socialNetworks: socialNetworks,
                            genres: genres,
                            photos: photos)
        Task {
            do {
                try await networkingService.createProfile(profile: profile)
                completaion(.success(()))
            } catch {
                print("Error creating profile: \(error)")
                completaion(.failure(error))
            }
        }
    }
    
    func getCities(completaion: @escaping (Result<[City], Error>) -> Void) {
        Task {
            do {
                let cities = try await networkingService.getCities()
                completaion(.success(cities))
            } catch {
                print(error)
                completaion(.failure(error))
            }
        }
    }
    
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        Task {
            do {
                let genres = try await networkingService.getGenres()
                completion(.success(genres))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func userDidEnterName(name: String) {
        self.name = name
    }
    
    func userDidEnterNickname(nickname: String) {
        self.nickname = nickname
    }
    
    func userDidEnterCity(city: City) {
        self.city = city
    }
    
    func userDidEnterSocialNetworks(socialNetworks: [SocialNetwork]) {
        self.socialNetworks = socialNetworks
    }
    
    func userDidEnterGenres(genres: [Genre]) {
        self.genres = genres
    }
    
    func userDidEnterPhotos(photos: [Photo]) {
        self.photos = photos
    }
}
