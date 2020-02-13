//
//  ViewController.swift
//  PSAccessManager-Example
//
//  Created by Sergey Prikhodko on 13.02.2020.
//  Copyright © 2020 Sergey Prikhodko. All rights reserved.
//

import UIKit
import PSAccessManager

class ViewController: UIViewController {
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let manager = PSAccessManager(biomericsOnly: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkButton.isEnabled = manager.isAvailable
        manager.reason = "Reason"
        descriptionLabel.numberOfLines = 0
    }
    
    @IBAction func check(_ sender: UIButton) {
        manager.check { [weak self] result in
            DispatchQueue.main.async { self?.catch(result) }
        }
    }
    
    private func `catch`(_ result: PSAccessManager.Result) {
        switch result {
        case .failure(let error):
            guard let error = error else { return }
            self.show(error)
            descriptionLabel.textColor = .red
            descriptionLabel.text = "Access denied\n\(error.localizedDescription)"
            
        case .denied:
            descriptionLabel.textColor = .red
            descriptionLabel.text = "Access denied"
            
        case .success:
            descriptionLabel.textColor = .green
            descriptionLabel.text = "Access confirmed"
        }
    }
    
    private func show(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}

