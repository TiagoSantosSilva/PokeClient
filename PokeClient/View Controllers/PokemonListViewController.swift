//
//  PokemonListViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

class PokemonListViewController: BaseViewController {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    internal var pokemonListViewModel: PokemonListViewModel!
    
    internal var pokemonList = [Pokemon]()
    internal var filteredPokemons = [Pokemon]()
    
    internal var searchController: UISearchController!
    internal var delayCounter = 0
    internal var finishedLoadingInitialTableCells = false
    
    // internal var pokemonTypes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonListViewModel = PokemonListViewModel()
        setupView()
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        setupNavigationBar()
        setupTableView()
        getData()
    }
    
    private func getData() {
        getPokemonData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
