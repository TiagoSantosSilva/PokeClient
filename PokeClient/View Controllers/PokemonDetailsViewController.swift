//
//  PokemonDetailsViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 22/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var pokemon: Pokemon?
    var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    private func setupController() {
        setupLabels()
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.isToolbarHidden = true
        navigationItem.title = "Details"
        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.setRightBarButton(editButton, animated: true)
    }
    
    @objc func editButtonTapped() {
        // Display New Pokemon View Controller with details already filled.
        print("Edit button tapped 👾")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, pokemon: Pokemon) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.pokemon = pokemon
    }
    
    func setupLabels() {
        guard let pokemon = pokemon else { return }
        
        guard let pokemonNumber = pokemon.dexNumber else { return }
        guard let pokemonName = pokemon.name else { return }
        guard let pokemonHeight = pokemon.height else { return }
        guard let pokemonWeight = pokemon.weight else { return }
        guard let pokemonType = pokemon.type else { return }
        
        numberLabel.text = String(describing: pokemonNumber)
        nameLabel.text = String(describing: pokemonName)
        heightLabel.text = "\(String(describing: pokemonHeight)) m"
        weightLabel.text = "\(String(describing: pokemonWeight)) kg"
        typeLabel.text = String(describing: pokemonType)
    }
}
