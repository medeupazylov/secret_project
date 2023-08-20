//
//  DefaultTableView.swift
//  Muslink
//
//  Created by Arystan on 13.08.2023.
//

import Foundation
import UIKit

protocol ChosenItemDelegate {
    func chosenItem(index: IndexPath?, item: String?)
}

protocol SearchItem {
    var title: String { get }
}

final class SearchTableView: UIViewController {
    
    //MARK: - Properties
    
    private var filteredData: [SearchItem] = []
    
    var data: [SearchItem] = [] {
        didSet {
            filteredData = data
            tableView.reloadData()
        }
    }
    
    let data2 = ["Almaty","Astana","Shymkent","Taraz","Turkestan"]
    
    //MARK: - LifeCycle
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        self.navigationItem.titleView = titleLabel
        setupTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
        setupNavigationBar()
    }
    
    private var selectedItemIndexPath: IndexPath?
    
    var delegate: ChosenItemDelegate?
    
    private var tableView = UITableView()
    
    var chosenItem: String?
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.backgroundColor = Color.elevatedBgColor.color
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        definesPresentationContext = true
        searchController.searchBar.backgroundColor = Color.neutral32.color
        searchController.searchBar.barTintColor = Color.elevatedBgColor.color
        return searchController
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.textColor = Color.neutral100.color
        
        return title
    }()
    
    private func setupTable() {
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    func updateChosenItem(index: IndexPath?, item: String?) {
        if var index = index {
            if let city = item,
               let dataIndex = data.firstIndex(where: { ($0.title) == city }) {
                index = IndexPath(row: dataIndex, section: 0)
            }
            
            if let selectedCell = tableView.cellForRow(at: index) as? SearchTableViewCell {
                selectedCell.showSelectIcon()
            }
        }
    }
    
    private func checkChoose(item: String) -> Bool {
        return chosenItem == item
    }
    
    private func setupUI() {
        view.backgroundColor = Color.elevatedBgColor.color
        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = Color.elevatedBgColor.color
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableHeaderView?.backgroundColor = Color.elevatedBgColor.color
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = Color.primaryBgColor.color
    }
    
}


extension SearchTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedItemIndexPath {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
            if let selectedCell = tableView.cellForRow(at: selectedIndexPath) as? SearchTableViewCell {
                selectedCell.hideSelectIcon()
            }
        }
        
        selectedItemIndexPath = indexPath
        chosenItem = filteredData[indexPath.row].title
        
        if let selectedCell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell {
            selectedCell.showSelectIcon()
        }
        
        delegate?.chosenItem(index: selectedItemIndexPath, item: chosenItem)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension SearchTableView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? data : data.filter({ item -> Bool in
                if let dataString = item.title as? String {
                    return dataString.range(of: searchText, options: .caseInsensitive) != nil
                }
                return false
            })
            
            tableView.reloadData()
        }
    }
}

extension SearchTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("Error: Could not dequeue custom cell")
        }
        
        if let item = data2[indexPath.row] as? String {
            cell.configure(with: item)
            if checkChoose(item: item) {
                cell.showSelectIcon()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data2.count
    }
}
