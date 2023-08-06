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
    
    var delegate: ChosenCityDelegate?
    
    var filteredData: [String]!
    
    lazy var tableView = UITableView()
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var selectedCityIndexPath: IndexPath?
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
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
    
    func updateChosenCity(index: IndexPath?) {
        if let index = index {
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
    
}

extension CitiesTable: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })
            
            tableView.reloadData()
        }
    }
}

extension CitiesTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitiesCell.identifier, for: indexPath) as? CitiesCell else {
            fatalError("Chert")
        }
        cell.configure(with: filteredData[indexPath.row])
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
        
        if let selectedCell = tableView.cellForRow(at: indexPath) as? CitiesCell {
            selectedCell.showSelectIcon()
        }
        
        delegate?.chosenCity(index: selectedCityIndexPath, city: data[selectedCityIndexPath?.row ?? 0])
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
