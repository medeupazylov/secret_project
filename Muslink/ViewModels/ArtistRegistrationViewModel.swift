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
    var city: String?
    var socialNetworks: [String]?
    var contacts: [String]?
    var genres: [String]?
    var moods: [String]?
    var biography: [String]?
    var photo: [String]?
    
    func userDidEnterName(name: String) {
        self.name = name
    }
    
    func userDidEnterNickname(nickname: String) {
        self.nickname = nickname
    }
    
    func userDidEnterCity(city: String) {
        self.city = city
    }
    
    func userDidEnterSocialNetworks(socialNetworks: [String]) {
        self.socialNetworks = socialNetworks
    }
    
    func userDidEnterContacts(contacts: [String]) {
        self.contacts = contacts
    }
    
    func userDidEnterGenres(genres: [String]) {
        self.genres = genres
    }
    
    func userDidEnterMoods(moods: [String]) {
        self.moods = moods
    }
    
    func userDidEnterBiography(biography: [String]) {
        self.biography = biography
    }
    
    func userDidEnterPhoto(photo: [String]) {
        self.photo = photo
    }
}
