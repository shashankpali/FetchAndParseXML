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
        self.title = "XML Fetcher"
        hideKeyboardWhenTappedAround()
    }
        
    //MARK: - UI Setup
    
    func setupUI() {
        setupFetchBtn()
        setupSearchInput()
        setupLoader()
    }
    
    func setupFetchBtn() {
        fetchBtn.setTitle("Fetch", for: .normal)
        fetchBtn.addTarget(self, action: #selector(tappedFetch), for: .touchUpInside)
        
        view.addSubview(fetchBtn)
        fetchBtn.translatesAutoresizingMaskIntoConstraints = false
        fetchBtn.set(widthRatio: 0.5, respectToView: view)
        fetchBtn.make(center: .horizontally, toView: view)
        fetchBtn.make(center: .vertically, toView: view)
    }
    
    func setupSearchInput() {
        searchField.placeholder = "Type or paste URL"
        searchField.borderStyle = .roundedRect
        searchField.returnKeyType = .go
        searchField.delegate = self
        
        view.addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.set(widthRatio: 0.8, respectToView: view)
        searchField.make(center: .horizontally, toView: view)
        searchField.place(aboveView: fetchBtn, distance: 10)
    }
    
    func setupLoader() {
        loader.hidesWhenStopped = true
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.make(center: .horizontally, toView: view)
        loader.place(aboveView: searchField, distance: 10)
    }
    
    //MARK: - Updat UI
    
    func updateUI(navigateWith objs: [Station]?, errorString: String?) {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.fetchBtn.isEnabled = true
            self.searchField.textColor = .black
            self.searchField.isUserInteractionEnabled = true
            guard objs != nil else {
                let alert = UIAlertController.init(title: "Error", message: errorString!, preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
                self.navigationController?.present(alert, animated: true, completion: nil)
                return
            }
            let destinationController = LoadXMLController.init(style: .plain)
            destinationController.tableData = objs
            self.navigationController?.pushViewController(destinationController, animated: true)
            self.searchField.text = ""
        }
        
        
    }
    
    //MARK: - Text Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        tappedFetch()
        return true
    }
    
    //MARK: - User Action
    
    @objc func tappedFetch() {
        guard searchField.text?.count != 0 else {
            searchField.becomeFirstResponder()
            let alert = UIAlertController.init(title: "Oops..!", message: "URL is required", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
            self.navigationController?.present(alert, animated: true, completion: nil)
            return
        }
        fetchBtn.isEnabled = false
        searchField.textColor = .lightGray
        searchField.isUserInteractionEnabled = false
        
        loader.startAnimating()
        
        Networking.get(forURLString: searchField.text!, policy: .reloadIgnoringCacheData) { success, data, errorStr in
            if success {
                let _ =  ParserHelper.init(withData: data!) { array in
                    self.updateUI(navigateWith: array, errorString: nil)
                }
            }else {
                self.updateUI(navigateWith: nil, errorString: errorStr)
            }
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //
}
