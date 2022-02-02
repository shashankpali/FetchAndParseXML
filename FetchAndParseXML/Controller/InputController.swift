//
//  ViewController.swift
//  FetchAndParseXML
//
//  Created by Shashank Pali on 02/02/22.
//

import UIKit

class InputController: UIViewController, UITextFieldDelegate {
    
    let searchField: UITextField = UITextField.init()
    let fetchBtn: UIButton = UIButton.init(type: .roundedRect)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupSearchInput()
        setupFetchBtn()
    }
    
    //MARK: - UI Setup
    
    func setupSearchInput() {
        searchField.placeholder = "Type or paste URL"
        searchField.borderStyle = .roundedRect
        searchField.delegate = self
        
        view.addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        ConstraintHelper.set(view: searchField, widthRatio: 0.8, respectToView: view)
        ConstraintHelper.make(view: searchField, center: .horizontally, toView: view)
        ConstraintHelper.make(view: searchField, center: .vertically, toView: view)
    }
    
    func setupFetchBtn() {
        fetchBtn.setTitle("Fetch", for: .normal)
        fetchBtn.addTarget(self, action: #selector(tappedFetch), for: .touchUpInside)

        view.addSubview(fetchBtn)
        fetchBtn.translatesAutoresizingMaskIntoConstraints = false
        ConstraintHelper.place(view: fetchBtn, belowView: searchField, distance: 10)
        ConstraintHelper.set(view: fetchBtn, widthRatio: 0.5, respectToView: searchField)
        ConstraintHelper.make(view: fetchBtn, center: .horizontally, toView: view)
    }
    
    //MARK: - Text Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    //MARK: - User Action
    
    @objc func tappedFetch() {
        guard searchField.text?.count != 0 else {
            searchField.becomeFirstResponder()
            return
        }
        
        navigationController?.pushViewController(LoadXMLController.init(style: .plain), animated: true)
    }
    
}

