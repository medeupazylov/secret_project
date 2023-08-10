//
//  ChoosePhotoViewController.swift
//  Muslink
//
//  Created by Аброрбек on 06.08.2023.
//

import UIKit
import Photos
import PhotosUI

final class ChoosePhotoViewController: UIViewController {
    
    private var numberofPhotos = 0
    private var photoIndex = 0
    
    // UI Elements
    private let progressView: DefaultProgressBar = {
        let progressView = DefaultProgressBar()
        progressView.updateProgress(withScreenOrder: 4)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Добавьте свое фото"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = Color.neutral100.color
        label.backgroundColor = Color.primaryBgColor.color
        label.textAlignment = .left
        
        return label
    }()
    
    private let imageView: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
            
        return imageView
    }()
    
    private let imageView1: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.alpha = 0
            
        return imageView
    }()
    
    private let imageView2: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.alpha = 0
            
        return imageView
    }()
    
    private let imageView3: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.alpha = 0
            
        return imageView
    }()
    
    private let imageView4: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.alpha = 0
            
        return imageView
    }()
    
    private let imagesStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .leading
        
        return view
    }()
    
    private lazy var continueButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Закончить")
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        
        return button
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Фото будут размещены в галерее профиля и поможет выгодно показать ваш образ"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = Color.neutral72.color
        label.textAlignment = .left
        label.numberOfLines = 2
        
        label.backgroundColor = Color.primaryBgColor.color
        return label
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTapGestureRecognizers()
        setupNavigationBar()
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        view.backgroundColor = Color.primaryBgColor.color
        view.addSubview(progressView)
        view.addSubview(titleLabel)
        view.addSubview(secondaryLabel)
        view.addSubview(imageView)
        view.addSubview(continueButton)
        
        imagesStackView.addArrangedSubview(imageView1)
        imagesStackView.addArrangedSubview(imageView2)
        imagesStackView.addArrangedSubview(imageView3)
        imagesStackView.addArrangedSubview(imageView4)
        view.addSubview(imagesStackView)
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: progressView.safeAreaLayoutGuide.bottomAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            secondaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            secondaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 194),
            imageView.heightAnchor.constraint(equalToConstant: 194),
        ])
        
        NSLayoutConstraint.activate([
            imagesStackView.heightAnchor.constraint(equalToConstant: 74),
            imagesStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            imagesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imagesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            imageView1.widthAnchor.constraint(equalToConstant: 74),
            imageView2.widthAnchor.constraint(equalToConstant: 74),
            imageView3.widthAnchor.constraint(equalToConstant: 74),
            imageView4.widthAnchor.constraint(equalToConstant: 74),
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -12.0),
        ])
    }
    
    func setupNavigationBar() {
        let title = UILabel()
        title.text = "Добавить фото"
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: self, action: #selector(moveBack))
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
    }
    
    // MARK: - Button Action
    
    @objc func buttonTapped() {
        // Add your button action logic here
    }
    
    @objc
    private func moveBack() {
        navigationController?.popViewController(animated: false)
    }
    
    // MARK: - Tap Gesture Recognizer
    
    func addTapGestureRecognizers() {
        let tapGesture0 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(tapGesture0)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView1.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView2.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView3.addGestureRecognizer(tapGesture3)
        
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView4.addGestureRecognizer(tapGesture4)
    }

    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        if let tappedImageView = sender.view as? UIImageView {
            switch tappedImageView {
            case imageView1:
                photoIndex = 1
            case imageView2:
                photoIndex = 2
            case imageView3:
                photoIndex = 3
            case imageView4:
                photoIndex = 4
            default:
                photoIndex = 0
            }
        }
        openPhotosApp()
    }

    
    func openPhotosApp() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            openPhotos()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        self?.openPhotos()
                    }
                }
            }
        case .denied, .restricted:
            print("Access to Photos is denied or restricted.")
        default:
            print("Unknown authorization status.")
        }
    }
    
    func openPhotos() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = .images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present (vc, animated: true)
    }
    // MARK: - Private Helpers
    
    private func updateImageView(with image: UIImage, at index: Int) {
        let imageViews = [imageView, imageView1, imageView2, imageView3, imageView4]
        
        guard index < imageViews.count else {
            return
        }
        
        imageViews[index].image = image
        if index < 4 {
            imageViews[index + 1].alpha = 1
        }
    }
    
    private func loadImage(from result: PHPickerResult, completion: @escaping (UIImage?) -> Void) {
        result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
            if let image = object as? UIImage, error == nil {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}

// MARK: - PHPickerViewControllerDelegate

extension ChoosePhotoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
//        for (_, result) in results.enumerated() {
//
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {
                return
            }
            self.loadImage(from: results[0]) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        self.updateImageView(with: image, at: self.photoIndex)
                    }
                }
            }
        }
//        }
    }
}

