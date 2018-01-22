//
//  PokemonListViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    private let dataManager = DataManager<Pokemon>(baseUrl: API.BaseUrl)
    private var pokemonList = [Pokemon]()
    private var filteredPokemons = [Pokemon]()
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        getPokemonData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PokemonListViewController {
    
    private func setupTableView() {
        let nibName = UINib(nibName: "PokemonCell", bundle: nil)
        pokemonTableView.register(nibName, forCellReuseIdentifier: "pokemonCell")
        
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
    }
    
    func setupNavigationBar() {
        setNavigationBarProperties()
        addSearchController()
        addNewPokemonButton()
    }
    
    fileprivate func setNavigationBarProperties() {
        navigationItem.title = "Pokémons"
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9732790589, green: 0.355466038, blue: 0.3788164854, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 40)!
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "AvenirNext-Bold", size: 20)!
        ]
    }
    
    fileprivate func addSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    fileprivate func addNewPokemonButton() {
        let newPokemonButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newPokemonButtonTapped))
        newPokemonButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.rightBarButtonItem = newPokemonButton
    }
    
    @objc func newPokemonButtonTapped() {
        let newPokemonViewController = NewPokemonViewController()
        present(newPokemonViewController, animated: true, completion: nil)
    }
}

extension PokemonListViewController {
    fileprivate func getPokemonData() {
        dataManager.getData(endpoint: API.PokemonEndpoint) { (response, error) in
            guard let pokemonListFromResponse = response as! [Pokemon]? else { return }
            self.pokemonList = pokemonListFromResponse
            self.pokemonTableView.reloadData()
        }
    }
}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard isFiltering() else { return pokemonList.count }
        return filteredPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonCell = pokemonTableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else { return UITableViewCell() }
        let pokemon = getPokemonToCell(indexPath: indexPath)
        
        guard let pokemonNumber = pokemon.dexNumber else { return UITableViewCell() }
        pokemonCell.dexNumberLabel.text = "#\(String(describing: pokemonNumber))"
        pokemonCell.pokemonNameLabel.text = pokemon.name
        return pokemonCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func getPokemonToCell(indexPath: IndexPath) -> Pokemon {
        guard isFiltering() else { return pokemonList[indexPath.row] }
        return filteredPokemons[indexPath.row]
    }
}

extension PokemonListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPokemons = pokemonList.filter({ (pokemon: Pokemon) -> Bool in
            return (pokemon.name?.lowercased().contains(searchText.lowercased()))!
        })
        
        pokemonTableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}
