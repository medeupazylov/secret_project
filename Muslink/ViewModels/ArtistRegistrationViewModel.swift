//
//  ArtistRegistrationViewModel.swift
//  Muslink
//
//  Created by Аброрбек on 11.08.2023.
//

import Foundation

@MainActor
final class ArtistRegistrationViewModel {
    var name: String?
    var nickname: String?
    var city: City?
    var socialNetworks: [SocialNetwork]?
    var genres: [Genre]?
    var photos: [Photo]?
    let networkingService = DefaultNetworkingService()
    
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
        print(profile)
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
