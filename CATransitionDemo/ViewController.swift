//
//  ViewController.swift
//  CATransitionDemo
//
//  Created by Winlentia on 6.10.2022.
//

import UIKit

struct TransitionPropertys {
    let type: [CATransitionType] = [.fade, .push, .reveal, .moveIn]
    let timingFunctions: [CAMediaTimingFunctionName] = [.default, .linear, .easeOut, .easeIn, .easeInEaseOut]
    let subType: [CATransitionSubtype] = [.fromTop,.fromLeft,.fromRight,.fromBottom]
    let fillMode: [CAMediaTimingFillMode] = [.forwards, .backwards, .both, .removed]
    let duration: [CFTimeInterval] = [0.1, 0.2, 0.3, 0.4, 0.5, 0.7, 1.0]
}

class ViewController: UIViewController {
    
    lazy var pickerView = UIPickerView()
    let presentButton = UIButton()
    let dataSource = TransitionPropertys()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        
        setupPresentButton()
        setupPickerView()
    }
    
    fileprivate func setupPickerView() {
        view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.layer.borderColor = UIColor.black.cgColor
        pickerView.layer.borderWidth = 1
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            pickerView.bottomAnchor.constraint(equalTo: presentButton.topAnchor, constant: 0),
        ])
    }
    
    
    fileprivate func setupPresentButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presentButtonAction))
        presentButton.addGestureRecognizer(gesture)
        view.addSubview(presentButton)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        presentButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        presentButton.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        presentButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        presentButton.titleLabel?.textAlignment = .center
        presentButton.setTitle("Present Animation", for: .normal)
    }
    
    @objc func presentButtonAction() {
        let viewController = PresentedViewController()
        let transition = CATransition()
        transition.duration = dataSource.duration[pickerView.selectedRow(inComponent: 0)]
        transition.type = dataSource.type[pickerView.selectedRow(inComponent: 1)]
        transition.timingFunction = CAMediaTimingFunction(name: dataSource.timingFunctions[pickerView.selectedRow(inComponent: 2)])
        transition.subtype = dataSource.subType[pickerView.selectedRow(inComponent: 3)]
        transition.fillMode = dataSource.fillMode[pickerView.selectedRow(inComponent: 4)]
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dataSource.duration.count
        } else if component == 1 {
            return dataSource.type.count
        } else if component == 2 {
            return dataSource.timingFunctions.count
        } else if component == 3 {
            return dataSource.subType.count
        } else if component == 4 {
            return dataSource.fillMode.count
        }
        return 0
    }
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        label.font = UIFont (name: "Helvetica Neue", size: 12)
        label.text =  getTitle(row: row, component: component)
        label.textAlignment = .center
        return label
    }
    
    func getTitle(row: Int, component: Int) -> String? {
        if component == 0 {
            return String(dataSource.duration[row])
        } else if component == 1 {
            return dataSource.type[row].rawValue
        } else if component == 2 {
            return dataSource.timingFunctions[row].rawValue
        } else if component == 3 {
            return dataSource.subType[row].rawValue
        } else if component == 4 {
            return dataSource.fillMode[row].rawValue
        }
        return nil
    }
}
