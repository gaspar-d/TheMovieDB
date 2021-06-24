//
//  movieDetailVC.swift
//  TheMovieDB_App
//
//  Created by Diogo Gaspar on 07/06/21.
//

import UIKit
import Nuke

class MovieDetailVC: UIViewController {
	var movie: MovieDetail?
	var safeArea: UILayoutGuide!
	
	var movieScene = UIImageView()
	let movieTitle = UILabel()
	let movieOverView = UILabel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		setupView()
	}
	
	private func setupView() {
		safeArea = view.layoutMarginsGuide
		setupMovieScene()
		setupMovieTitle()
		setupMovieOverview()
		setupDataDetails()
	}
	
	private func setupDataDetails() {
		guard let movie = movie else {return}
		movieTitle.text = movie.title
		movieOverView.text = movie.overview
		Nuke.loadImage(with: APICaller.shared.api.baseImageURL + movie.backdropPath, into: movieScene)
	}
	
	private func setupMovieScene() {
		view.addSubview(movieScene)
		movieScene.translatesAutoresizingMaskIntoConstraints = false
		movieScene.contentMode = .scaleAspectFill
		movieScene.layer.opacity = 0.3
		
		NSLayoutConstraint.activate([
			movieScene.topAnchor.constraint(equalTo: view.topAnchor),
			movieScene.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			movieScene.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			movieScene.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
	
	private func setupMovieTitle() {
		view.addSubview(movieTitle)
		movieTitle.translatesAutoresizingMaskIntoConstraints = false
		movieTitle.font = UIFont.boldSystemFont(ofSize: 42)
		movieTitle.textColor = UIColor.white
		movieTitle.shadowColor = .gray
		movieTitle.shadowOffset = CGSize(width: 1, height: 1)
		movieTitle.numberOfLines = 4
		
		NSLayoutConstraint.activate([
			movieTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			movieTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
			movieTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
		])
	}
	
	private func setupMovieOverview() {
		view.addSubview(movieOverView)
		movieOverView.translatesAutoresizingMaskIntoConstraints = false
		movieOverView.font = UIFont(name: "Verdana", size: 16)
		movieOverView.textColor = UIColor.white
		movieOverView.shadowColor = .gray
		movieOverView.shadowOffset = CGSize(width: 1, height: 1)
		movieOverView.numberOfLines = 50

		NSLayoutConstraint.activate([
			movieOverView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			movieOverView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 14),
			movieOverView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
		])
	}
}
