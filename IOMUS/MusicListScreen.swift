//
//  MusicListScreen.swift
//  IOMUS
//
//  Created by Yerassyl Duisenbi on 12.03.2018.
//  Copyright © 2018 Yerassyl Duisenbi. All rights reserved.
//

import UIKit

class MusicListScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    var library = MusicLibrary().library
    var filteredSongs = MusicLibrary().library
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        filteredSongs = library.filter({( music : MusicLibrary) -> Bool in
//            return music.library.contains(where: (["title":"artist"]))
//            return music.library["title"].lowercased().contains(searchText.lowercased())
//        })
        
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let sc = UISearchController(searchResultsController: nil)
        navigationItem.searchController = sc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Songs"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        print("viewDidLoad")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell") as! MusicCell
        cell.artistName.text = library[indexPath.row]["artist"]
        cell.songName.text = library[indexPath.row]["title"]

        if let coverImage = library[indexPath.row]["coverImage"] {
            cell.musicImageView.image = UIImage(named: "\(coverImage).jpg")
        }
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPlayer", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayer"{
            let playerVC = segue.destination as! PlayerViewController
            let indexPath = tableView.indexPathForSelectedRow!
            playerVC.trackID = indexPath.row
            
            
        }
    }
    
    

}
