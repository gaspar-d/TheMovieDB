//
//  ViewController.swift
//  TheMovieDB_App
//
//  Created by Diogo Gaspar on 06/06/21.
//

import UIKit
import Nuke

class ViewController: UIViewController {
	let baseImageURL = APICaller.shared.api.baseImageURL
	var tableView = UITableView()
	var moviesList = [MovieDetail]()
	var safeArea: UILayoutGuide!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupNavigationBar()
		setupTableView()
		
		let asyncFetch = {(fetchMovie: [Result]) in
			DispatchQueue.main.async {
				let movieDetailList = fetchMovie.map { movie in
					return MovieDetail(adult: movie.adult, backdropPath: movie.backdropPath, originalTitle: movie.originalTitle, overview: movie.overview, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title)
				}
				self.moviesList = movieDetailList
				self.tableView.reloadData()
			}
		}
		
		APICaller.shared.alamofireFetch(onCompletion: asyncFetch)
	}
	
//MARK: -> Setup 
	func setupNavigationBar() {
		title = "The Movie DB"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func setupTableView() {
		view.addSubview(tableView)
		safeArea = view.layoutMarginsGuide
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(MovieCell.self, forCellReuseIdentifier: "cell")
		tableView.dataSource = self
		tableView.delegate = self
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
}

//MARK: -> UITableViewDataSource
extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return moviesList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let movie = moviesList[indexPath.row]

		guard let movieCell = cell as? MovieCell else { return cell }
		
		Nuke.loadImage(with: baseImageURL + movie.posterPath, into: movieCell.movieImage)
		movieCell.movieTitle.text = movie.title
		movieCell.movieOverView.text = movie.overview

		return cell
	}
}

//MARK: -> UITableViewDelegate
extension ViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let favoriteAction = UIContextualAction(style: .normal, title: "Favoritos") { action, view, completionHandler in
			// Terminar de implementar esses favoritos
			//  salvar dados com userDefaults e setar um estado para o swipe com liked ? true : false 
			
			completionHandler(true)
		}
		
		favoriteAction.backgroundColor = .purple
		return UISwipeActionsConfiguration(actions: [favoriteAction])
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let movie = self.moviesList[indexPath.row]
		let movieDetailVC = MovieDetailVC()
		movieDetailVC.movie = movie
		self.present(movieDetailVC, animated: true)
	}
}
