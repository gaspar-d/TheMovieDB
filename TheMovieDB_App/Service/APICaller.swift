//
//  APICaller.swift
//  TheMovieDB_App
//
//  Created by Diogo Gaspar on 07/06/21.
//

import Foundation
import Alamofire

class APICaller {
	static let shared = APICaller()
	let api = Constants()
	
	func alamofireFetch(onCompletion: @escaping ([Result]) -> Void) {
		let urlString = api.baseAPIUrl + api.APIKey
		let url = URL(string: urlString)!
		
		AF.request(url).responseJSON { response in
			guard let data = response.data else {
				print("Error while requesting data")
				return
			}
			
			guard let movieList = try? JSONDecoder().decode(Welcome.self, from: data) else {
				print("Couldn't decode JSON")
				return
			}
			
			onCompletion(movieList.results)
		}
	}
}

