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
    
    internal var pokemonTypes = [PokemonType]()
    
    internal var urlUsedToOpenApp: URL?
    
    convenience init(url: URL?) {
        self.init()
        self.urlUsedToOpenApp = url
    }
    
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
        getPokemonTypes()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("openUrl"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(urlOpened), name: Notification.Name("openUrl"), object: nil)
    }
    
    @objc func urlOpened(notification: Notification) {
        print("Url opened")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func pushDetailsView(cell: PokemonCell) {
        
        guard let tappedPokemonId = getTappedPokemonId(cell: cell) else {
            // Present Alert Controller
            return
        }
        
        guard let cellIndexPath = pokemonTableView.indexPath(for: cell) else { return }
        
        let pokemonDetailsViewController = PokemonDetailsViewController(indexPath: cellIndexPath, pokemonId: tappedPokemonId, pokemonTypes: pokemonTypes, pokemonListViewController: self)
        navigationController?.pushViewController(pokemonDetailsViewController, animated: true)
    }
    
    func getTappedPokemonId(cell: PokemonCell) -> Int? {
        let cellIndex = pokemonTableView.indexPath(for: cell)
        guard let index = cellIndex else { return nil }
        
        guard isFiltering() else { return pokemonList[index.row].id }
        return filteredPokemons[index.row].id
    }
    
    func newPokemonCreated(pokemon: Pokemon) {
        pokemonList.append(pokemon)
        let newPokemonIndexPath = IndexPath(row: pokemonList.count - 1, section: 0)
        pokemonTableView.insertRows(at: [newPokemonIndexPath], with: .bottom)
        pokemonTableView.scrollToRow(at: newPokemonIndexPath, at: .bottom, animated: false)
    }
    
    func pokemonEdited(pokemon: Pokemon, indexPath: IndexPath) {
        pokemonList[indexPath.row] = pokemon
        pokemonTableView.reloadData()
    }
}
