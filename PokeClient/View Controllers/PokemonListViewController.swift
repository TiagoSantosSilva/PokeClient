//
//  ViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class PokemonListViewController: UINavigationController {
    
    weak var searchBar: UISearchBar!
    
    private let dataManager = DataManager<Pokemon>(baseUrl: API.BaseUrl)
    private var pokemonList = [Pokemon]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTableView()
    }
}

extension PokemonListViewController {
    private func setupTableView() {
        tableView.register(PokemonCell.self, forCellReuseIdentifier: "pokemonCell")
        tableView.delegate = self
        tableView.dataSource = self
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
            guard let pokemonListFromResponse = response as! [Pokemon]? else { return }
            self.pokemonList = pokemonListFromResponse
        }
    }
}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let pokemonCell = PokemonCell(style: .default, reuseIdentifier: "pokemonCell")
//        pokemonCell.dexNumberLabel.text = "#001"
//        pokemonCell.pokemonNameLabel.text = "Tyranitar"
//        return pokemonCell
        return UITableViewCell()
    }
}
