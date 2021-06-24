//
//  MovieCell.swift
//  TheMovieDB_App
//
//  Created by Diogo Gaspar on 06/06/21.
//

import UIKit

class MovieCell: UITableViewCell {
	var safeArea: UILayoutGuide!
	var movieImage = UIImageView()
	let movieTitle = UILabel()
	let movieOverView = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView() {
		safeArea = layoutMarginsGuide
		setupImageView()
		setupMovieTitle()
		setupMovieOverview()
	}
	
	private func setupImageView() {
		addSubview(movieImage)
		movieImage.translatesAutoresizingMaskIntoConstraints = false
		movieImage.contentMode = .scaleAspectFit
		
		NSLayoutConstraint.activate([
			movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
			movieImage.centerYAnchor.constraint(equalTo: centerYAnchor),
			movieImage.topAnchor.constraint(equalTo: safeArea.topAnchor),
//			movieImage.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
			movieImage.heightAnchor.constraint(equalToConstant: 110),
			movieImage.widthAnchor.constraint(equalToConstant: 100),
		])
	}
	
	private func setupMovieTitle() {
		addSubview(movieTitle)
		movieTitle.translatesAutoresizingMaskIntoConstraints = false
		movieTitle.font = UIFont.boldSystemFont(ofSize: 18)
		movieTitle.numberOfLines = 2
		
		NSLayoutConstraint.activate([
			movieTitle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 15),
			movieTitle.topAnchor.constraint(equalTo: safeArea.topAnchor),
			movieTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
		])
	}
	
	private func setupMovieOverview() {
		addSubview(movieOverView)
		movieOverView.translatesAutoresizingMaskIntoConstraints = false
		movieOverView.font = UIFont(name: "Verdana", size: 14)
		movieOverView.numberOfLines = 4
		movieOverView.clipsToBounds = true
		
		NSLayoutConstraint.activate([
			movieOverView.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
			movieOverView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 4),
			movieOverView.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor),
			movieOverView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
		])
	}
}
