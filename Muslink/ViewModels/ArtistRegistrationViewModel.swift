//
//  ArtistRegistrationViewModel.swift
//  Muslink
//
//  Created by Аброрбек on 11.08.2023.
//

import Foundation

final class ArtistRegistrationViewModel {
    var name: String?
    var nickname: String?
    var city: City?
    var socialNetworks: [SocialNetwork]?
    var genres: [Genre]?
    var photos: [Photo]?
    let networkingService = DefaultNetworkingService()
    
    func createProfile() async {
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
        
        // Now you have all the required properties, you can proceed with creating the profile
        let profile = Artist(
                            name: name,
                            nickname: nickname,
                            city: city,
                            socialNetworks: socialNetworks,
                            genres: genres,
                            photos: photos)
        print(profile)
        
        do {
            try await networkingService.createProfile(profile: profile)
        } catch {
            print("Error creating profile: \(error)")
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
