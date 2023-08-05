//
//  ChooseZhanrViewController.swift
//  Muslink
//
//  Created by Аброрбек on 05.08.2023.
//

import UIKit

final class ChooseZnanrViewController: UIViewController {
    
    //MARK: - UI elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: OptionsTableViewCell.identifier)
        return tableView
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let tableData: [String: [String]] = ["one" : ["medeu", "abror", "medeu"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(progressView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            progressView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        // Constraints for tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ChooseZnanrViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionsTableViewCell.identifier, for: indexPath) as? OptionsTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(context: tableData["one"]!)
        
        
//        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
}
