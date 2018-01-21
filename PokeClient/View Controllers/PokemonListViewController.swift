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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        getPokemonData()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PokemonListViewController {
    
    private func setupTableView() {
        pokemonTableView.register(PokemonCell.self, forCellReuseIdentifier: "pokemonCell")
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
    }
    
    fileprivate func addSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        navigationItem.searchController = searchController
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
            print(response ?? "🤯")
            guard let pokemonListFromResponse = response as! [Pokemon]? else { return }
            self.pokemonList = pokemonListFromResponse
            self.pokemonTableView.reloadData()
        }
    }
}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
