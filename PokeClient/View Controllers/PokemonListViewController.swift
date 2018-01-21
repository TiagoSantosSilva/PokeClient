//
//  ViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    weak var searchBar: UISearchBar!
    
    private let dataManager = DataManager<Pokemon>(baseUrl: API.BaseUrl)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonData()
    }
    
    func createSearchBar() {
        self.navigationItem.titleView?.isHidden = true
        searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Enter your search here."
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
}

extension PokemonListViewController {
    @IBAction func addButtonTapped(_ sender: Any) {
    }
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        self.navigationItem.titleView?.isHidden = false
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.titleView?.isHidden = true
    }
}

extension PokemonListViewController {
    fileprivate func getPokemonData() {
        dataManager.getData(endpoint: API.PokemonEndpoint) { (response, error) in
            print(response ?? "🤯")
        }
    }
}
