//
//  ApplicationRequestsViewController.swift
//  Muslink
//
//  Created by Аброрбек on 25.08.2023.
//

import UIKit

final class ApplicationRequestsViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel: MyApplicationsViewModel
    private var applications: [Application] = [popSongApplication, documentaryApplication, edmApplication, popSongApplication, documentaryApplication, edmApplication, popSongApplication, documentaryApplication, edmApplication]
    
    private var genres: [Genre] = [Genre(id: 0, name: "новые"), Genre(id: 0, name: "одобренные"), Genre(id: 0, name: "отклоненные")]
    
    private var selectedGenres: [Genre] = []
    
    //MARK: - Lifecycle
    
    init(viewModel: MyApplicationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.backgroundColor = Color.primaryBgColor.color
        viewModel.fetchApplications { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let applications):
                self.applications = applications
                self.tableView.reloadData()
            case .failure(_):
                print("NetworkingError")
            }
        }
        setupTableView()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = CustomViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.clipsToBounds = false
        collection.backgroundColor = Color.primaryBgColor.color
        collection.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsCollectionViewCell.identifier)
        return collection
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.backgroundColor = .clear
        
        table.register(ApplicationTableViewCell.self, forCellReuseIdentifier: ApplicationTableViewCell.identifier)
        
        return table
    }()
    
    private func setupTableView() {
        addTableViewToHierarchy()
        setTableViewConstraints()
        setTableViewDataSourceAndDelegate()
        setupNavigationBar()
    }
    
    private func addTableViewToHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    private func setTableViewConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setTableViewDataSourceAndDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupNavigationBar() {
        let title = UILabel()
        title.text = "Мои заявки"
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: self, action: #selector(moveBack))
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
    }
    
    @objc
    private func moveBack() {
        navigationController?.popViewController(animated: false)
    }
}

extension ApplicationRequestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applications.count // Number of rows in the table view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationTableViewCell.identifier, for: indexPath) as? ApplicationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: applications[indexPath.row])
        cell.view = self
        return cell
    }
    
    
}

extension ApplicationRequestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(LabelApplicationViewController(), animated: true)
        // Handle row selection if needed
    }
}

extension ApplicationRequestsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath)  as? ButtonsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.title = genres[indexPath.row].name
        if indexPath.row == 0 {
            cell.select()
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (genres[indexPath.item].name.size(
                withAttributes:
                    [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width) + 25,
                height: 40
            )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            guard let selectedCell = collectionView.cellForItem(at: indexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
            let isSelected = selectedCell.select()
            let text = selectedCell.getType()
            if isSelected {
                selectedGenres.append(Genre(id: indexPath.row, name: text))
            } else {
                if let index = selectedGenres.firstIndex(where: {
                    $0.name == text
                }) {
                    selectedGenres.remove(at: index)
                }
            }
        }
    }
}



let popSongApplication = Application(
    id: 1,
    track: Track(
        track: TrackFile(id: 12345, link: "https://example.com/pop-song.mp3"),
        name: "Catchy Tune",
        language: "RUSSIAN",
        genres: [Genre(id: 1, name: "Pop")],
        subGenres: [SubGenre(id: 101, name: "Electropop")],
        moods: [Mood(id: 201, name: "Upbeat"), Mood(id: 202, name: "Energetic")],
        startCrop: 10,
        endCrop: 180
    ),
    pitch: "Petr Berlov",
    purposes: [Purpose(id: 301, name: "Commercial Advertisement"), Purpose(id: 302, name: "YouTube Video")],
    status: .sent,
    sendDate: "2023-08-25",
    comment: "Great track!",
    rejectReasons: []
)

let documentaryApplication = Application(
    id: 2,
    track: Track(
        track: TrackFile(id: 67890, link: "https://example.com/documentary-music.mp3"),
        name: "Epic Journeys",
        language: "RUSSIAN",
        genres: [Genre(id: 2, name: "Orchestral")],
        subGenres: [SubGenre(id: 201, name: "Film Score")],
        moods: [Mood(id: 301, name: "Inspiring"), Mood(id: 302, name: "Serene")],
        startCrop: 0,
        endCrop: 300
    ),
    pitch: "German Borkovski",
    purposes: [Purpose(id: 401, name: "Documentary Film")],
    status: .sent,
    sendDate: "2023-08-25",
    comment: "Perfect fit for our documentary.",
    rejectReasons: []
)

let edmApplication = Application(
    id: 3,
    track: Track(
        track: TrackFile(id: 54321, link: "https://example.com/edm-track.mp3"),
        name: "Electro Pulse",
        language: "RUSSIAN",
        genres: [Genre(id: 3, name: "Electronic")],
        subGenres: [SubGenre(id: 301, name: "EDM")],
        moods: [Mood(id: 401, name: "Energetic"), Mood(id: 402, name: "Party")],
        startCrop: 30,
        endCrop: 240
    ),
    pitch: "Alex Popov",
    purposes: [Purpose(id: 501, name: "Music Streaming")],
    status: .sent,
    sendDate: "2023-08-25",
    comment: "Awesome EDM track!",
    rejectReasons: []
)
