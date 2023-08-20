//
//  MyApplicationsViewController.swift
//  Muslink
//
//  Created by Аброрбек on 18.08.2023.
//

import UIKit

final class MyApplicationsViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel: MyApplicationsViewModel
    private var applications: [Application] = []
    
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
        view.addSubview(tableView)
    }
    
    private func setTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
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

extension MyApplicationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applications.count // Number of rows in the table view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ApplicationTableViewCell.identifier, for: indexPath) as? ApplicationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: applications[indexPath.row])
        
        return cell
    }
}

extension MyApplicationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle row selection if needed
    }
}

