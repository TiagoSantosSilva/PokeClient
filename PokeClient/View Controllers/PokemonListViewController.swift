//
//  PokemonListViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    internal var apiClient = ApiClient(baseUrl: API.ImageUrl)
    internal let dataManager = DataManager<Pokemon>(baseUrl: API.BaseUrl)
    
    internal var pokemonList = [Pokemon]()
    internal var filteredPokemons = [Pokemon]()
    
    internal var searchController: UISearchController!
    internal var delayCounter = 0
    internal var finishedLoadingInitialTableCells = false
    
    internal var reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
    }
    
    private func setupView() {
        setupNavigationBar()
        setupTableView()
        getPokemonData()
        startNotifier()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func pushDetailsView(cell: PokemonCell) {
        
        guard let tappedPokemon = getTappedPokemon(cell: cell) else {
            // Present Alert Controller
            return
        }
        
        let pokemonDetailsViewController = PokemonDetailsViewController(pokemon: tappedPokemon, pokemonListViewController: self)
        navigationController?.pushViewController(pokemonDetailsViewController, animated: true)
    }
    
    func getTappedPokemon(cell: PokemonCell) -> Pokemon? {
        let cellIndex = pokemonTableView.indexPath(for: cell)
        guard let index = cellIndex else { return nil }
        
        guard isFiltering() else { return pokemonList[index.row] }
        return filteredPokemons[index.row]
    }
    
    func newPokemonCreated(pokemon: Pokemon) {
        pokemonList.append(pokemon)
        let newPokemonIndexPath = IndexPath(row: pokemonList.count - 1, section: 0)
        pokemonTableView.insertRows(at: [newPokemonIndexPath], with: .bottom)
        pokemonTableView.scrollToRow(at: newPokemonIndexPath, at: .bottom, animated: false)
    }
    
    func pokemonEdited(pokemon: Pokemon) {
        // Get Cell of pokemon By Id
        // Pull into this View Controller?
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
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9402940869, green: 0.324482739, blue: 0.3114508092, alpha: 1)
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
        let newPokemonViewController = NewPokemonViewController(pokemonListViewController: self)
        present(newPokemonViewController, animated: true, completion: nil)
    }
}
