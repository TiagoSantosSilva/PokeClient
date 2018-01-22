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
    
    internal let dataManager = DataManager<Pokemon>(baseUrl: API.BaseUrl)
    internal var pokemonList = [Pokemon]()
    internal var filteredPokemons = [Pokemon]()
    
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
    
    private func setupNavigationBar() {
        setNavigationBarProperties()
        addSearchController()
        addNewPokemonButton()
    }
    
    private func setNavigationBarProperties() {
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
    
    private func addSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func addNewPokemonButton() {
        let newPokemonButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newPokemonButtonTapped))
        newPokemonButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.rightBarButtonItem = newPokemonButton
    }
    
    @objc func newPokemonButtonTapped() {
        let newPokemonViewController = NewPokemonViewController()
        present(newPokemonViewController, animated: true, completion: nil)
    }
}
