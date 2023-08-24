//
//  MyApplicationsViewModel.swift
//  Muslink
//
//  Created by Аброрбек on 19.08.2023.
//

import Foundation

@MainActor
final class MyApplicationsViewModel {
    
    //MARK: - Properties
    private let networkingService: NetworkingService
    private var applications: [Application] = []
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func fetchApplications(completion: @escaping (Result<[Application], Error>) -> Void) {
        Task {
            do {
                let fetchedApplications = try await networkingService.getApplications()
                applications = fetchedApplications
                completion(.success(fetchedApplications))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func getApplication(at index: Int) -> Application? {
        guard index >= 0 && index < applications.count else {
            return nil
        }
        return applications[index]
    }
    
    func createApplication(application: Application, completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                try await networkingService.createApplication(application: application)
                applications.append(application)
                completion(.success(()))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func updateApplication(at index: Int, with newApplication: Application, completion: @escaping (Result<Void, Error>) -> Void) {
//        guard index >= 0 && index < applications.count else {
//            completion(.failure(_))
//            return
//        }
        
        Task {
            do {
                try await networkingService.updateApplication(application: newApplication)
                applications[index] = newApplication
                completion(.success(()))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
    }
}

