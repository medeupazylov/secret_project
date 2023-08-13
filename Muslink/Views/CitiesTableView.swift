//
//  CitiesTable.swift
//  Muslink
//
//  Created by Arystan on 05.08.2023.
//

import Foundation
import UIKit

protocol ChosenCityDelegate {
    func chosenCity(index: IndexPath?, city: String?)
}

final class CitiesTable: UIViewController {
    
    //MARK: - Properties
    
    var data: [City] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var filteredData: [City] = []
    
    var delegate: ChosenCityDelegate?
    
    var chosenCity: String = ""
    
    lazy var tableView = UITableView()
    
    var selectedCityIndexPath: IndexPath?
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.backgroundColor = Color.elevatedBgColor.color
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        definesPresentationContext = true
        searchController.searchBar.backgroundColor = Color.neutral32.color
        searchController.searchBar.barTintColor = Color.elevatedBgColor.color
        return searchController
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Город"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Color.neutral100.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredData = data
        tableView.register(CitiesCell.self, forCellReuseIdentifier: CitiesCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        setupUI()
    }
    
    func updateChosenCity(index: IndexPath?, city: String?) {
        if var index = index {
            if (city != data[index.row].name) {
                for i in index.row..<data.count {
                    if( city == data[i].name ) {
                        index = IndexPath(row: i, section: 0)
                    }
                }
            }
            if let selectedCell = tableView.cellForRow(at: index) as? CitiesCell {
                selectedCell.showSelectIcon()
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = Color.elevatedBgColor.color
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = Color.elevatedBgColor.color
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableHeaderView?.backgroundColor = Color.elevatedBgColor.color
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func checkChoose(city: String) -> Bool {
        return chosenCity == city
    }
    
}

extension CitiesTable: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? data : data.filter { city in
                return city.name.range(of: searchText, options: .caseInsensitive) != nil
            }
            
            tableView.reloadData()
        }
    }
}

extension CitiesTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitiesCell.identifier, for: indexPath) as? CitiesCell else {
            fatalError("Chert")
        }
        cell.configure(with: filteredData[indexPath.row].name)
        if(filteredData[indexPath.row].name == chosenCity) {
            cell.showSelectIcon()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
}

extension CitiesTable: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedCityIndexPath {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
            if let selectedCell = tableView.cellForRow(at: selectedIndexPath) as? CitiesCell {
                selectedCell.hideSelectIcon()
            }
        }
        
        selectedCityIndexPath = indexPath
        chosenCity = filteredData[indexPath.row].name
        
        if let selectedCell = tableView.cellForRow(at: indexPath) as? CitiesCell {
            selectedCell.showSelectIcon()
        }
        
        delegate?.chosenCity(index: selectedCityIndexPath, city: chosenCity)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
