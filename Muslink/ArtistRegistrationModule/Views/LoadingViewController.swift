//
//  LoadingViewController.swift
//  Muslink
//
//  Created by Аброрбек on 24.08.2023.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0.7
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    let centerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vinyl")
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let downloadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Загрузка..."
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = Color.primaryMain.color
        label.textAlignment = .center
        
        label.backgroundColor = .clear
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.insertSubview(blurEffectView, at: 0)
        blurEffectView.pinToEdges(of: view)
        view.addSubview(downloadingLabel)
        
        view.addSubview(centerImageView)
        NSLayoutConstraint.activate([
            centerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerImageView.widthAnchor.constraint(equalToConstant: 200), // Adjust the size as needed
            centerImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            downloadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadingLabel.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 10),
            downloadingLabel.widthAnchor.constraint(equalToConstant: 100), // Adjust the size as needed
            downloadingLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

extension UIView {
    func pinToEdges(of superview: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}

