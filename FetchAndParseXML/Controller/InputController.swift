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
    let loader = UIActivityIndicatorView.init(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupUI()
    }
    
    //MARK: - UI Setup
    
    func setupUI() {
        setupSearchInput()
        setupFetchBtn()
        setupLoader()
    }
    
    func setupSearchInput() {
        searchField.placeholder = "Type or paste URL"
        searchField.borderStyle = .roundedRect
        searchField.delegate = self
        
        view.addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.set(widthRatio: 0.8, respectToView: view)
        searchField.make(center: .horizontally, toView: view)
        searchField.make(center: .vertically, toView: view)
    }
    
    func setupFetchBtn() {
        fetchBtn.setTitle("Fetch", for: .normal)
        fetchBtn.addTarget(self, action: #selector(tappedFetch), for: .touchUpInside)
        
        view.addSubview(fetchBtn)
        fetchBtn.translatesAutoresizingMaskIntoConstraints = false
        fetchBtn.place(belowView: searchField, distance: 10)
        fetchBtn.set(widthRatio: 0.5, respectToView: searchField)
        fetchBtn.make(center: .horizontally, toView: view)
    }
    
    func setupLoader() {
        loader.hidesWhenStopped = true
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.make(center: .horizontally, toView: view)
        loader.place(aboveView: searchField, distance: 10)
    }
    
    //MARK: - Updat UI
    
    func updateUI(navigateWith objs: [Station]?) {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.fetchBtn.isEnabled = true
            self.searchField.textColor = .black
            self.searchField.isUserInteractionEnabled = true
            guard objs != nil else {return}
            let destinationController = LoadXMLController.init(style: .plain)
            destinationController.tableData = objs
            self.navigationController?.pushViewController(destinationController, animated: true)
        }
    }
    
    //MARK: - Text Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    //MARK: - User Action
    
    @objc func tappedFetch() {
        guard let text = searchField.text else {
            searchField.becomeFirstResponder()
            return
        }
        fetchBtn.isEnabled = false
        searchField.textColor = .lightGray
        searchField.isUserInteractionEnabled = false
        
        loader.startAnimating()
        
        Networking.get(forURLString: text) { success, data, errorStr in
            if success {
                let _ =  XMLParserHelper.init(withData: data!) { array in
                    self.updateUI(navigateWith: array)
                }
            }else {
                self.updateUI(navigateWith: nil)
            }
        }
    }
    //
}
